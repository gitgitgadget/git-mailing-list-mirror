From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: More git bisect modes
Date: Thu, 05 Mar 2009 19:05:42 +0900
Message-ID: <20090305190542.6117@nanako3.lavabit.com>
References: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAV7-0006to-2K
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbZCEKGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZCEKGy
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:06:54 -0500
Received: from karen.lavabit.com ([72.249.41.33]:40083 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbZCEKGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:06:53 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 9120711B847;
	Thu,  5 Mar 2009 04:06:51 -0600 (CST)
Received: from 3885.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 8VCLGT99EB5C; Thu, 05 Mar 2009 04:06:51 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=h0k641U5382JqupSD9p6GKZOy3n1C69FGVIkxgY0r1ZVMvFjdHlSatIqXLOe1h+4BPHe8FmsnLkezguu2GGx8IQAdjap+lBVlWvMyKXBm3IWQz+Nr6akukSa48H+bvOn/jIfm437+9ej5xMeJHAnUUgp6yBkJlBOc5Y/j+0jNtY=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112281>

Quoting John Tapsell <johnflux@gmail.com>:

> * An exponential back-off.  Typically I know that HEAD is broken, and
> I don't know when it used to work.

I thought 'git bisect' already worked with only bad commit(s) without any good commit for a long time?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
