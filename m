From: david@lang.hm
Subject: Re: immutable tags?
Date: Mon, 28 Dec 2009 12:25:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0912281223440.24130@asgard.lang.hm>
References: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Carlos Santana <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 21:26:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMAH-0004m8-5N
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 21:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbZL1UZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 15:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbZL1UZ6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 15:25:58 -0500
Received: from mail.lang.hm ([64.81.33.126]:41705 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbZL1UZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 15:25:58 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id nBSKPuRN006624;
	Mon, 28 Dec 2009 12:25:56 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135755>

On Mon, 28 Dec 2009, Carlos Santana wrote:

> I would like to know if there is any difference between branches and
> tags. Is it only conceptual - convention to be followed by a developer
> or some technical difference?  e.g. : Is it possible to create
> immutable tags so that nothing can be checked in to that 'tagged
> directory'?

tags are pointers into the tree. tags do not change.

in git directories are not tagged, so I'm not sure what you are working 
towards here.

David Lang
