From: "Li Frank-B20596" <Frank.Li@freescale.com>
Subject: [QGit] Some suggestion
Date: Thu, 25 Sep 2008 13:24:11 +0800
Message-ID: <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net>
References: <gbak2u$v9b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 07:25:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KijM1-0002YP-OR
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 07:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYIYFYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 01:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbYIYFYS
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 01:24:18 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:59202 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbYIYFYS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 01:24:18 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m8P5OE6r015472
	for <git@vger.kernel.org>; Wed, 24 Sep 2008 22:24:15 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m8P5OCbL024297
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 00:24:13 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <gbak2u$v9b$1@ger.gmane.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [QGit] Some suggestion
Thread-Index: AckdcBFdO/OpsisJQUWm9urho5xfXABXVWLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96724>

Can add below function at qgit?
===Difference other version===
	1. user choose a commit, 
	2. right click 
		Check working dir
		View patch
		....
		[Diff with other commit]

	3. change icon +
	4. user choose other commit

	QGit show list of changed files. 
	click one files, call extern diff tool show difference. 

=== file view ===
	Can use different color to high light current commit change. 	
	
