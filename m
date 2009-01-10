From: nadim khemir <nadim@khemir.net>
Subject: Re: collapsing commits with rebase
Date: Sat, 10 Jan 2009 11:26:43 +0100
Message-ID: <200901101126.43650.nadim@khemir.net>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 11:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLb4d-0001u0-E8
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbZAJK0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 05:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbZAJK0q
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:26:46 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:53068 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753442AbZAJK0p (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jan 2009 05:26:45 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id 5197E940033
	for <git@vger.kernel.org>; Sat, 10 Jan 2009 11:26:44 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.143])
	by khemir.net (Postfix) with ESMTP id C32812F04001
	for <git@vger.kernel.org>; Sat, 10 Jan 2009 11:26:43 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105085>

On Thursday 08 January 2009 01.08.44 Geoff Russell wrote:
> Dear gits,
>
> I have a series of commits:
>
>     A---B---C---D---E---F
>
> I want to collapse B---C---D into one single commit. git rebase -i B  will
> allow me to do this, but I'm looking for a non-interactive incantation.

Hi Geoff, Could you please share with use the final (tested) solution? I'd be 
interrested to see how you did implement plan B if you did.

Cheers, Nadim.
