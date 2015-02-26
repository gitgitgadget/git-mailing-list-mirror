From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad
 file descriptor
Date: Thu, 26 Feb 2015 21:27:21 +0000
Message-ID: <20150226212721.GA2930@dcvr.yhbt.net>
References: <CAK6Z60ciheWOUGOv1sYcA==B2WR1Rs_eMU+9a=R3FBwc_37CyQ@mail.gmail.com>
 <CAK6Z60fhyY3wPG6hx7YJ4y7wZsWb=33JhqejmpVBgZLGdB1XMA@mail.gmail.com>
 <cbcb926c1b7edd31548a15ea4966a35@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <ipso@snappymail.ca>, Minty <mintywalker@gmail.com>,
	Nico =?utf-8?B?U2NobMO2bWVy?= <nico.schloemer@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5xu-000401-HR
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbbBZV1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:27:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58446 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbbBZV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 16:27:22 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99594200CD;
	Thu, 26 Feb 2015 21:27:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cbcb926c1b7edd31548a15ea4966a35@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264464>

"Kyle J. McKay" <mackyle@gmail.com> wrote:
> The updated patch with the additional fix is below.

Thanks, signed-off and pushed to master on git://bogomips.org/git-svn
I've dropped my "destroy all tempfiles..." patch.
