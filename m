From: "Ryan Taylor" <ryan.taylor@leeds-art.ac.uk>
Subject: Mirroring mySQL using Git
Date: Tue, 6 May 2008 14:03:01 +0100
Message-ID: <4B58A837F454E14AA0453EDBADE96A62B5F2A2@mildred.leeds-art.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 06 15:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtMpy-0008JG-Cy
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 15:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbYEFNDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 09:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755475AbYEFNDM
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 09:03:12 -0400
Received: from mail.leeds-art.ac.uk ([195.195.164.241]:30392 "EHLO
	mildred.leeds-art.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755455AbYEFNDL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 09:03:11 -0400
Received: (qmail 6391 invoked from network); 6 May 2008 13:03:07 -0000
Received: from 17.130.10.172.in-addr.arpa (HELO mildred.leeds-art.ac.uk) (172.10.130.17)
  by 0 with SMTP; 6 May 2008 13:03:06 -0000
X-ECSC-UBE-ID: 6382.1210078986.1
X-ECSC-UBE-IP: 172.10.130.17
X-MimeOLE: Produced By Microsoft Exchange V6.5
x-cr-hashedpuzzle: 4MY= AEJQ Ajvl CnyA Crbc EN9B ES7m FJTT Frcn Hr0q HxAg ICI3 IzwH J1x2 LbB7 Ljie;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{5F59CE34-DEE9-47AF-87F5-FD5E16BE3645};cgB5AGEAbgAuAHQAYQB5AGwAbwByAEAAbABlAGUAZABzAC0AYQByAHQALgBhAGMALgB1AGsA;Tue, 06 May 2008 13:03:01 GMT;TQBpAHIAcgBvAHIAaQBuAGcAIABtAHkAUwBRAEwAIAB1AHMAaQBuAGcAIABHAGkAdAA=
Content-class: urn:content-classes:message
x-cr-puzzleid: {5F59CE34-DEE9-47AF-87F5-FD5E16BE3645}
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mirroring mySQL using Git
Thread-Index: AcivVmG1Pw/KrZB7TLCO1P2xM9+G1gAIDIigAAC4vSA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81357>

Hi,

I'm wanting to mirror my mysql databases from my live web box to my dev
box. The database are updated by a CMS on the live box and I need to be
able to transfer these updates to the dev box.

Is this possible with git?

And if so how?

Cheers

Ryan
