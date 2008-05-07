From: "Ryan Taylor" <ryan.taylor@leeds-art.ac.uk>
Subject: Removing from index
Date: Wed, 7 May 2008 09:06:01 +0100
Message-ID: <4B58A837F454E14AA0453EDBADE96A62B5F3C9@mildred.leeds-art.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 10:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtegm-0002DZ-J4
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 10:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbYEGIGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 04:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbYEGIGN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 04:06:13 -0400
Received: from mail.leeds-art.ac.uk ([195.195.164.241]:53835 "EHLO
	mildred.leeds-art.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754743AbYEGIGI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 04:06:08 -0400
Received: (qmail 10242 invoked from network); 7 May 2008 08:06:06 -0000
Received: from 17.130.10.172.in-addr.arpa (HELO mildred.leeds-art.ac.uk) (172.10.130.17)
  by 0 with SMTP; 7 May 2008 08:06:05 -0000
X-ECSC-UBE-ID: 10235.1210147565.1
X-ECSC-UBE-IP: 172.10.130.17
X-MimeOLE: Produced By Microsoft Exchange V6.5
x-cr-hashedpuzzle: BWCi Bg7n Bzc2 DAhv DaHN D0o9 ENhI FuoR F3kJ GBY2 GFcB HD1t H4zm JFbQ J3ka Ktr5;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{388B53D2-8C04-4809-BED7-B514AFAD848F};cgB5AGEAbgAuAHQAYQB5AGwAbwByAEAAbABlAGUAZABzAC0AYQByAHQALgBhAGMALgB1AGsA;Wed, 07 May 2008 08:06:01 GMT;UgBlAG0AbwB2AGkAbgBnACAAZgByAG8AbQAgAGkAbgBkAGUAeAA=
Content-class: urn:content-classes:message
x-cr-puzzleid: {388B53D2-8C04-4809-BED7-B514AFAD848F}
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Removing from index
Thread-Index: AciwGTA+5R37HTiYRu+q2OztLyU+Jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81412>

Hi,

I've been a bit daft and told git to track a logs folder on my live box.
So now I'm pushing and pulling log file between my live box and my dev
box.

I've tried adding logs into my exclude file and also running the git rm
command on *.log to remove them from the index but they're still being
tracked?

I'm new to git. Can anyone shed any light?

Cheers

Ryan
