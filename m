From: Wink Saville <wink@saville.com>
Subject: Re: Git gui error RenderBadPicture
Date: Sun, 5 Jul 2009 17:47:36 -0700
Message-ID: <d4cf37a60907051747n4ca55c28oed36a0349ace7948@mail.gmail.com>
References: <d4cf37a60907051640k215595a1n95b720201243fc89@mail.gmail.com>
	 <20090706001658.GA3745@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Mon Jul 06 02:47:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNcN2-0004uB-24
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 02:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444AbZGFArf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2009 20:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756255AbZGFAre
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 20:47:34 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:49495 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbZGFAre convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 20:47:34 -0400
Received: by yxe26 with SMTP id 26so5106112yxe.33
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 17:47:36 -0700 (PDT)
Received: by 10.100.211.3 with SMTP id j3mr7519380ang.19.1246841256330; Sun, 
	05 Jul 2009 17:47:36 -0700 (PDT)
In-Reply-To: <20090706001658.GA3745@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122770>

A little more information, using Ctrl-Q for exiting doesn't
get around the problem. That only works if you happen to
exit immediately, if you do something such as click on a
file and show the differences it also reports the same error.

-- Wink

On Sun, Jul 5, 2009 at 5:16 PM, Jeff Epler<jepler@unpythonic.net> wrote=
:
> This is likely due to a bug in Tk, the widget toolkit of 'git gui'. =A0=
The
> bug was set to "obsolete" back in 2007, but there's no indication the
> problem was fixed.
>
> https://sourceforge.net/tracker/?func=3Ddetail&atid=3D112997&aid=3D18=
21174&group_id=3D12997
>
> Jeff
>
