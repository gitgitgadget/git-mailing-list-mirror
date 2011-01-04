From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] gitweb: make logo optional
Date: Tue, 4 Jan 2011 15:24:30 -0800
Message-ID: <20110104232430.GB15889@dcvr.yhbt.net>
References: <20110104050206.GA8280@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 00:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaGF1-0000Qz-5s
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 00:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946Ab1ADXY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 18:24:29 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56074 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab1ADXY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 18:24:29 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3457E1F87B;
	Tue,  4 Jan 2011 23:24:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110104050206.GA8280@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164525>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> These patches were last seen in the instaweb 1.7.1 maintenance
> thread[1] but I believe they are independently useful.  The
> idea is to allow disabling the logo in gitweb.
> 
> Jonathan Nieder (2):
>   gitweb: skip logo in atom feed when there is none
>   gitweb: make logo optional

This series looks good to me (especially considering my strong
dislike of logos/icons on the web :>)

Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
