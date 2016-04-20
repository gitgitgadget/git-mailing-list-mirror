From: "Philip Oakley" <philipoakley@iee.org>
Subject: Tcl/Tk now has a little 'c' style language..
Date: Wed, 20 Apr 2016 23:45:46 +0100
Organization: OPDS
Message-ID: <9C2D8C85399647FFAF918B7260C93EB9@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 00:45:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at0sb-00027b-78
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 00:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbcDTWps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 18:45:48 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:15826 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcDTWpr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 18:45:47 -0400
Received: from PhilipOakley ([92.22.28.167])
	by smtp.talktalk.net with SMTP
	id t0sSaTV9HavFft0sSaR3uh; Wed, 20 Apr 2016 23:45:45 +0100
X-Originating-IP: [92.22.28.167]
X-Spam: 0
X-OAuthority: v=2.1 cv=M9ntU3Es c=1 sm=1 tr=0 a=Vx6b4YafqH5AAhvJeISbbQ==:117
 a=Vx6b4YafqH5AAhvJeISbbQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=e6c7lSkLAAAA:8 a=15GXwTAegi8SsyhKxDkA:9
 a=wPNLvfGTeEIA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFL4TLoyy1KWliJ6tq/0+AEts/w6d/tfBsmDLy3HA4h/eXBv96sXGVOiX76dZzCDekwTONfhSc8KIXpJFLu2P6tOCyGjuMnXleuI0bccql/PnnlVCIIi
 NdNu6xlPV6pYm2BdtSKbmgW2B+JTAOPYPA9MZueLFG7bHqGR2i5OO+rr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292088>

The CodeProject news today mentioned the release of the 'L' (little) 
language which integrates with Tcl/Tk and compiles to Tcl/Tk  byte code.

This should be of interest to those looking at the Git Gui and Gitk code, in 
particular the examples showing code simplification (easire to 
read/understand).

The project page is at http://www.little-lang.org, with the original L paper 
(pdf) at http://www.little-lang.org/little.pdf and looks to have some solid 
documentation.

--

Philip 
