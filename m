From: Jeremy Davis <Jeremy.Davis@idahosif.org>
Subject: Importing from RTC to GIT
Date: Wed, 3 Sep 2014 12:22:20 -0600
Message-ID: <43622BFE4D7C4B4094E4A212BD8B2B0353B69B31C7@isifboise45.isif.state.id.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:22:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPFCN-0005uS-5p
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 20:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbaICSWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2014 14:22:22 -0400
Received: from mail.idahosif.org ([207.114.236.251]:36568 "EHLO
	mail.idahosif.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaICSWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2014 14:22:21 -0400
X-Sendio-Return-Path: Jeremy.Davis@idahosif.org
X-Sendio-Delivered: Wed, 03 Sep 2014 12:22:21 -0600
Received: (sendio-qmail 1382 invoked from network); 3 Sep 2014 18:22:21 -0000
X-Sendio-SenderIP: 10.221.40.49
X-Sendio-RemoteSenderIP: 10.221.40.49
X-Sendio-MessageID: 1409768540.1378.1
Received: from unknown (HELO IdahoSIF7.idahosif.org) (10.221.40.49)
  by mail.idahosif.org with SMTP; 3 Sep 2014 18:22:20 -0000
Received: from ISIFBOISE9.ISIF.STATE.ID.US (10.221.210.109) by
 IdahoSIF7.idahosif.org (10.221.40.49) with Microsoft SMTP Server (TLS) id
 8.3.348.2; Wed, 3 Sep 2014 12:22:06 -0600
Received: from isifboise45.isif.state.id.us ([::1]) by
 ISIFBOISE9.isif.state.id.us ([::1]) with mapi; Wed, 3 Sep 2014 12:22:20 -0600
Thread-Topic: Importing from RTC to GIT
Thread-Index: Ac/Hop/pRVMPuyXWQ82gJBby1xDYBAAARaBA
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256400>

We are currently investigating whether to move from RTC (source control=
) to GIT and wanted to find out if there is more information available =
than what we have found in http://stackoverflow.com/questions/23928927/=
how-to-migrate-from-rtc-jazz-to-git

We really need to preserve the version history of all artifacts and wan=
ted to see if there is an import utility available to do this.=A0 If no=
t, we can go through and import off of our milestone baselines in separ=
ate workspaces but this can be fairly time consuming for us to grab all=
 needed baselines that we will want to preserve.=A0 We are not planning=
 on archiving RTC so getting the history out for all versioned artifact=
s is extremely important.

Thanks,
Jeremy Davis

ALM Architect
Idaho State Insurance Fund
Phone: 208-332-2586
Cell Phone: 970-215-2945
Email: jdavis@idahosif.org
Website: www.idahosif.org
