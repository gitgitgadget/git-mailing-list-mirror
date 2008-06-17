From: <Patrick.Higgins@cexp.com>
Subject: RE:  Incorrect default for git stash?
Date: Tue, 17 Jun 2008 16:29:40 -0600
Message-ID: <911589C97062424796D53B625CEC0025E46170@USCOBRMFA-SE-70.northamerica.cexp.com>
References: <loom.20080617T220852-922@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <raible@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:37:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8joD-0006iy-51
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055AbYFQWgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758002AbYFQWgx
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:36:53 -0400
Received: from mx02.cexp.com ([170.131.136.83]:46007 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755961AbYFQWgx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 18:36:53 -0400
Received: from mailgate2.cexp.com (uscobrmfa-se-07.cexp.com [170.131.144.37])
	by mx02.cexp.com (Postfix) with ESMTP id B9F9122189F
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 16:29:41 -0600 (MDT)
Received: from USCOBRMFA-SE-70.northamerica.cexp.com ([10.128.26.36]) by USCOBRMFA-SE-51.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Jun 2008 16:29:40 -0600
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: A<loom.20080617T220852-922@post.gmane.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Incorrect default for git stash?
Thread-Index: AcjQyMJDTpViDl+RQQGXS7d6+2q2FAAAIL2A
X-OriginalArrivalTime: 17 Jun 2008 22:29:40.0902 (UTC) FILETIME=[A23DC460:01C8D0C9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85338>

Eric Raible wrote:

> git branch -> list branches
> git tag    -> list tags
> git stash  -> create a stash

git commit -> list commits?
git checkout -> list checkouts?
git prune -> list prunes?
git pull -> list pullables?

Why would you expect stash to behave like branch and tag?
