From: Laszlo Papp <djszapi@archlinux.us>
Subject: Re: Implement --password option for git svn perl script
Date: Tue, 2 Feb 2010 14:16:06 +0100
Message-ID: <a362e8011002020516i5d5adcf7k6553d62e633cec88@mail.gmail.com>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com>
	 <001636ed7681994278047e4e4a6f@google.com>
	 <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com>
	 <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com>
	 <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com>
	 <1976ea661002012030h23aa415ek30aa6db23cb88d0e@mail.gmail.com>
	 <a362e8011002012237t640dd8b9sa1da0d221f5d03b6@mail.gmail.com>
	 <20100202090538.GA28437@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Frank Li <lznuaa@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 14:16:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcIc3-0000l0-DO
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 14:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab0BBNQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 08:16:11 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:44569 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab0BBNQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 08:16:09 -0500
Received: by yxe27 with SMTP id 27so25766yxe.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 05:16:09 -0800 (PST)
Received: by 10.100.233.35 with SMTP id f35mr7432564anh.233.1265116566610; 
	Tue, 02 Feb 2010 05:16:06 -0800 (PST)
In-Reply-To: <20100202090538.GA28437@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138716>

> Since SVN already caches passwords in a mostly secure location on disk
> (at least on *nix), shouldn't git svn be able to use the password cache
> SVN uses?

@Frank Li
@Eric Wong

Maybe you can check whether how TortoiseSVN or SVN client code handle
this situation, because it's the same server, but 'just' the client
side is different a little bit, but the same situation happen there in
case TortoiseSVN a popup menu appears when you try to authenticate
yourself.

Second way is to ask on the SVN mailing list, how they use it, or
maybe I'm totally wrong with it :P

Best Regards,
Laszlo Papp
