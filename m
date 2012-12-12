From: "Srb, Michal" <michal.srb11@imperial.ac.uk>
Subject: FW: Git log --graph doesn't output color when redirected
Date: Wed, 12 Dec 2012 17:35:17 +0000
Message-ID: <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:36:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiqE3-0002R8-DW
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab2LLRfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 12:35:50 -0500
Received: from smtp1.cc.ic.ac.uk ([155.198.5.155]:44593 "EHLO
	smtp1.cc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab2LLRft convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2012 12:35:49 -0500
Received: from icexch-h2.ic.ac.uk ([2001:630:12:610::112])
	by smtp1.cc.ic.ac.uk with esmtp (Exim 4.77)
	(envelope-from <michal.srb11@imperial.ac.uk>)
	id 1TiqDk-0002Pn-Ep
	for git@vger.kernel.org; Wed, 12 Dec 2012 17:35:48 +0000
Received: from icexch-m3.ic.ac.uk ([fe80::bd02:fc07:49f4:cded]) by
 icexch-h2.ic.ac.uk ([fe80::c06e:5d25:f2dc:fe8%10]) with mapi id
 14.02.0309.002; Wed, 12 Dec 2012 17:35:17 +0000
Thread-Topic: Git log --graph doesn't output color when redirected
Thread-Index: Ac3Yjq+meElrbMKnQcaf7CGn5O9CJQAAFB29
In-Reply-To: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.29.152.206]
X-IC-MsgID: 1TiqDk-0002Pn-Ep
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211370>

Unlike --pretty-format, --graph doesn=92t output colors when the git lo=
g output
is redirected.
=20
Tested on Ubuntu 12.04 and msys on Windows 8.
=20
Is there a setting somewhere in config to change this?
=20
Thanks,
=20
Michal
