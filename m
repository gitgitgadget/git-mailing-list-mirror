From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Teach Makefile to respect external variables: CFLAGS and others.
Date: Wed, 13 Jun 2007 11:53:35 +0400
Message-ID: <20070613075335.GR86872@void.codelabs.ru>
References: <20070613054229.GM86872@void.codelabs.ru> <7v4plcgzer.fsf@assigned-by-dhcp.pobox.com> <20070613071514.GP86872@void.codelabs.ru> <7vhcpcfglr.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: sam@ravnborg.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 09:53:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyNfk-0005Tj-Iu
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 09:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbXFMHxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 03:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756012AbXFMHxn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 03:53:43 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:62702 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbXFMHxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 03:53:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=UlT3a7QCGkN80cRfHwbqxPwLqIDcvXMHPfMRKdf7XL7Q8ySN9i4Mujin2ugqBn4wnTObHpom3d9cdx2jU+Muw/vClf0pzLStgFZKQHQNTCDl7bs13aHHD8Pvd7PXcgTbtRSwDUzas1LQU26n1oAhViFP4VumYHHL7SmOa4IqUXw=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HyNfg-000Cji-7r; Wed, 13 Jun 2007 11:53:40 +0400
Content-Disposition: inline
In-Reply-To: <7vhcpcfglr.fsf@assigned-by-dhcp.pobox.com>
X-Spam-Status: No, score=-1.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50030>

Junio,

Wed, Jun 13, 2007 at 12:39:28AM -0700, Junio C Hamano wrote:
> > But anyway, this patch is only my suggestion, and it can be
> > thrown away :)
> 
> Oh, I will, very gladly ;-), as it is obviously inferior than
> how we currently do our build.

OK, then this topic can be closed ;))

Thank you!
-- 
Eygene
