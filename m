From: Adam Megacz <adam@megacz.com>
Subject: Re: [PATCH] Display author and committer after "git commit"
Date: Mon, 11 Jan 2010 04:53:08 +0000
Organization: Myself
Message-ID: <xuu28wc59r9n.fsf@nowhere.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com> <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com> <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com> <7v4omz17xz.fsf@alter.siamese.dyndns.org> <xuu28wc9xd42.fsf@nowhere.com> <7vskagh9fg.fsf@alter.siamese.dyndns.org> <xuu2fx6d9rzb.fsf_-_@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 05:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUCHZ-0002Nv-5q
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 05:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab0AKExc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865Ab0AKExb
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 23:53:31 -0500
Received: from lo.gmane.org ([80.91.229.12]:55755 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab0AKExb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 23:53:31 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NUCHR-0002LF-7A
	for git@vger.kernel.org; Mon, 11 Jan 2010 05:53:29 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 05:53:29 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 05:53:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:+P2RtJqlg+nSZKzujpZ3kgvEoa0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136603>


Adam Megacz <adam@megacz.com> writes:
> either taken from the working tree or else displayed to the user for
> sanity checking purposes.  Since the author/committer information is
> immutable and not taken from the working tree,

s/working tree/index/g

Sorry,

  - a
