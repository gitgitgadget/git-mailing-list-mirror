From: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
Subject: git-diff across branches?
Date: Tue, 08 Jan 2008 05:44:14 -0300
Message-ID: <478337DE.7@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 09:42:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCA2q-0001Hr-TN
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 09:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbYAHImN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 03:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbYAHImN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 03:42:13 -0500
Received: from gulana.terra.com ([66.119.66.229]:51937 "EHLO gulana.terra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbYAHImN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 03:42:13 -0500
Received: from feluga.terra.com (feluga.terra.com [66.119.66.183])
	by gulana.terra.com (Postfix) with ESMTP id 5E2E010CC10A
	for <git@vger.kernel.org>; Tue,  8 Jan 2008 03:42:09 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: 7179eae481ebb6a2af1f0630c7954a67
Received-SPF: none (feluga.terra.com: 66.119.66.183 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.183; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.32.186])
	(authenticated user ggarra@advancedsl.com.ar)
	by feluga.terra.com (Postfix) with ESMTP id 5B5DC2E2931
	for <git@vger.kernel.org>; Tue,  8 Jan 2008 03:41:52 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69848>


I was wondering if there was a way to make a git-diff across (local)=20
branches.

Something like:

$ git-diff --branch test1 HEAD --branch test2 HEAD  file.cpp
(would show a diff for file.cpp between test1 HEAD and test2 HEAD)



--=20
Gonzalo Garramu=F1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
