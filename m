From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Tue, 03 Feb 2009 19:05:17 +0900
Message-ID: <20090203190517.6117@nanako3.lavabit.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <alpine.DEB.1.00.0901251622310.14855@racer> <7vwscjceec.fsf@gitster.siamese.dyndns.org> <200901252303.29204.jnareb@gmail.com> <alpine.DEB.1.00.0901260026310.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 11:07:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUIBm-0001Ib-AG
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 11:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbZBCKGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 05:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZBCKGA
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 05:06:00 -0500
Received: from karen.lavabit.com ([72.249.41.33]:49610 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbZBCKF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 05:05:59 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 78C45C86AD;
	Tue,  3 Feb 2009 04:05:58 -0600 (CST)
Received: from 1843.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 7TANVNHIGT0S; Tue, 03 Feb 2009 04:05:58 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=FBqxwx5RyxBsrjGg6zkxMgJHe5vf2DZ6eTpQX8dnGHxd+6+OzzBNTeaVxe429uWJiSaXduqstNBktZhHaEBlNDW+aa2u3Z3ECGJPbF9IHCaYWq29OT+gAzQvQWDXrA8JEwLZffZ3p1MYPftAD87bXWiyRJQleydjL0Y211q2mUQ=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.DEB.1.00.0901260026310.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108173>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Nanako had a script at some stage; I would prefer an subcommand to "git 
> rerere" which reconstructs the whole merge in-memory, and then records the 
> conflict's resolution.

I'm sorry but I'm not sure what script of mine you are referring to.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
