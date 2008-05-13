From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: How to (re-)create .git/logs/refs
Date: Tue, 13 May 2008 15:50:10 +0200
Message-ID: <200805131550.10834.hs4233@mail.mn-solutions.de>
References: <200805081256.11465.hs4233@mail.mn-solutions.de> <200805131413.14753.hs4233@mail.mn-solutions.de> <m33aom5oc2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 15:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvuxp-0003WZ-G9
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 15:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310AbYEMNxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 09:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756281AbYEMNxl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 09:53:41 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:3048 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbYEMNxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 09:53:40 -0400
Received: from lin01.mn-solutions.de (pD95FBA72.dip0.t-ipconnect.de [217.95.186.114])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 3654C5E42DE;
	Tue, 13 May 2008 15:53:38 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id C57FB1E0038; Tue, 13 May 2008 15:50:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id 839081E0004;
	Tue, 13 May 2008 15:50:40 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <m33aom5oc2.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82030>

Hi Jakub !

Thanks for your trick. That completely solves my problem *)



*) I'm fully aware that that "git log" might show something like:

2 days ago: Blah
3 days ago: Muh
3 days ago: Blech
2 days ago: Huwa!

But this won't happen in my case --- at least not in repositories 
freshly converted from SVN.
