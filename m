From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 09:07:50 -0600
Message-ID: <slrnfs5me6.lhp.jgoerzen@katherina.lan.complete.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <4d8e3fd30802241456l6c02a040te21643c830cf0e46@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 16:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTewz-0008T1-FS
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 16:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYBYPI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 10:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbYBYPI1
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 10:08:27 -0500
Received: from main.gmane.org ([80.91.229.2]:38314 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbYBYPI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 10:08:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JTewE-0000iz-GD
	for git@vger.kernel.org; Mon, 25 Feb 2008 15:08:18 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 15:08:18 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 15:08:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75033>

On 2008-02-24, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 2/25/08, John Goerzen > Would it also be possible to unify
> git-format-patch and
>> git-send-email into a single command that generates and sends the patch(es)?
>
> I can't think of how to unify the commands from the ui point of view.
> What do you suggest?
>
> However, i like the idea of a --send commad line option to
> git-format-patch that calls git-send-email to create and send the
> patch series.

That sounds reasonable to me.

I'm all in favor of less typing, so git-email sounds even better :-)

-- John
