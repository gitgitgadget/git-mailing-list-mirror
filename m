From: James Pickens <jepicken@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 23:38:48 +0000 (UTC)
Message-ID: <loom.20080724T233753-857@post.gmane.org>
References: <20080723145518.GA29035@laptop>  <loom.20080724T065737-580@post.gmane.org>  <fcaeb9bf0807240200x10a6a267h4c37e4566da967ba@mail.gmail.com>  <loom.20080724T171151-310@post.gmane.org> <fcaeb9bf0807241623m3fbd476dyc41990d8ef0888e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 01:40:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAPg-0006Gk-PR
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741AbYGXXjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYGXXi7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:38:59 -0400
Received: from main.gmane.org ([80.91.229.2]:59839 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbYGXXi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:38:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KMAOe-00033g-Sp
	for git@vger.kernel.org; Thu, 24 Jul 2008 23:38:57 +0000
Received: from fmfwpr01.fm.intel.com ([192.55.52.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 23:38:56 +0000
Received: from jepicken by fmfwpr01.fm.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 23:38:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.55.52.1 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89974>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> "git checkout B10" form has already been taken. How about "git
> checkout --add-path" and "git checkout --remove-path"?

That would be fine.  The specific syntax is not that important to me, as long as
the capability exists.

James
