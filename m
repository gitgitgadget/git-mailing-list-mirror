From: "Frawley, Sarah" <sarah.frawley@intel.com>
Subject: Query on git submodules
Date: Fri, 22 May 2015 13:46:24 +0000
Message-ID: <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com>
References: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 22 15:46:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvnHU-0007KS-Uj
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978AbbEVNq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2015 09:46:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:27964 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756636AbbEVNq0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 09:46:26 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP; 22 May 2015 06:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,475,1427785200"; 
   d="scan'208";a="698893554"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by orsmga001.jf.intel.com with ESMTP; 22 May 2015 06:46:25 -0700
Received: from irsmsx110.ger.corp.intel.com ([169.254.15.124]) by
 IRSMSX107.ger.corp.intel.com ([169.254.10.94]) with mapi id 14.03.0224.002;
 Fri, 22 May 2015 14:46:23 +0100
Thread-Topic: Query on git submodules
Thread-Index: AdCSSWETsB/dvpOtTAu+b+O2ywQWlACTA2hA
In-Reply-To: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269716>

Hi there
I am a design automation engineer supporting 200+ designers who use git=
 for hardware design.=A0 We also use the submodule feature where we can=
 have quite complex hierarchy's with 10+ layers.=A0 We have experience =
issues with re-use of design projects was we move from one derivative t=
o another due to the complexity of the hierarchy along with lack of dis=
cipline (using absolute paths in .gitmodule files). To enforce more dis=
cipline I am currently working on a pre-commit hook to check the integr=
ity of .gitmodule files.=A0 I would be interested in seeing how other u=
sers in the community find submodules for large scale projects and if t=
here are any best known methods for using them.


Operating system (specifically which version)  - Suse Linux (SLES11SP2)
Git version (git --version) - 1.7.12.2


Thanks,
Sarah=20

-------------------------------------------------------------
Intel Ireland Limited (Branch)
Collinstown Industrial Park, Leixlip, County Kildare, Ireland
Registered Number: E902934

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
