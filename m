From: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
Subject: Git and securing a repository
Date: Wed, 02 Jan 2008 04:13:57 -0300
Message-ID: <477B39B5.5010107@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 07:13:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9wqc-0006xH-Nt
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 07:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbYABGM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 01:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbYABGM2
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 01:12:28 -0500
Received: from gulana.terra.com ([66.119.66.229]:32868 "EHLO gulana.terra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbYABGM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 01:12:28 -0500
Received: from elimba.terra.com (elimba.terra.com [66.119.66.67])
	by gulana.terra.com (Postfix) with ESMTP id BE64E10CC0FC
	for <git@vger.kernel.org>; Wed,  2 Jan 2008 01:12:26 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: 77449ea4b14af039b4250d33058d1fa3
Received-SPF: none (elimba.terra.com: 66.119.66.67 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.67; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.33.238])
	(authenticated user ggarra@advancedsl.com.ar)
	by elimba.terra.com (Postfix) with ESMTP id A42651BC053
	for <git@vger.kernel.org>; Wed,  2 Jan 2008 01:12:19 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69458>


I've been using git for some time and love it.  For open source project=
s=20
there's clearly nothing currently better.

However, I am now using git for proprietary elements, which in the=20
future I may need or want to partially restrict access to.  The idea=20
being that at my company some (junior) developers should not be given=20
access to some elements.  That means either that some full git=20
repository should be password protected or even portions of the same=20
repository.

Another desirable way to protect elements might be only giving=20
clone/pull access to a repository (or portion of it) but not permission=
s=20
to push in changes.

I have not seen or read much about how git deals with accesses and=20
permissions.  Can anyone point me to some documentation if some or all=20
of this is possible?


--=20
Gonzalo Garramu=F1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
