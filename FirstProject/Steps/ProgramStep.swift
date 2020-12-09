//
//  ProgramStep.swift
//  FirstProject
//
//  Created by Alexey Tatarchenko on 06.12.2020.
//

import RxFlow

enum ProgramStep: Step {
  case homePage
  case tracks(Program)
}
