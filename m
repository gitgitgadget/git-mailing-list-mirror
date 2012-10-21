From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: In search of a version control system
Date: Sun, 21 Oct 2012 08:20:13 -0400
Message-ID: <CAM9Z-nnQjhehJEpyhyTY=rsK_f=2gTOUMVTycn7-Lao8Gog0pA@mail.gmail.com>
References: <1349719581.76671.YahooMailNeo@web122505.mail.ne1.yahoo.com>
	<CALkWK0kCbLxPMbxh=CLAE8UkkNFNqDa1QbtdM_-Q+Qr3SRh46Q@mail.gmail.com>
	<vpqa9vwstp3.fsf@grenoble-inp.fr>
	<CAJDDKr5PxM3a6TjfdVoCp1VzgCFBKQ6YGhpN-BO-D=CyVTQX3w@mail.gmail.com>
	<vpq4nm4rxsy.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Maurice Francois <francoismaurice2001@yahoo.ca>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 21 14:20:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPuW4-0001Q2-LH
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 14:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab2JUMUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 08:20:16 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34526 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab2JUMUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 08:20:14 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so690706bkc.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pnKfvF3U/HoSi40CZNiA1YJlQJJGAvZcMQphgf+0DvA=;
        b=JNXvxLuqIXzjHZ35IDTQxIT4AiJGNkkh/zVOVGWzSV19D4UX2nAUXsTsKK8h9ooz7P
         SiM3vdrdW38CMp9nlAhsJJPlhv0IxTB54YvayazEQEWyLTVJzW/FTn1KNomC16uCppAv
         fN7BveobkP8Eg9IuaQxZndz86zrUfSNVxDGQAUPxuT1IFq48m51WxebFQO0M2pK/1Npt
         z65LicRatjfxUjBFUPj213UrKLs/3wYxXM/eMLvmw6dSMTKPdsr0dFLHSpatRQjGOAvo
         xORxwJacmC9tCKAZVjW1FjLHpfE2p9SGOu++CJEH+65E/9sgMMHSNnYmwNE3krYdnGf5
         63rA==
Received: by 10.204.5.151 with SMTP id 23mr1897418bkv.3.1350822013512; Sun, 21
 Oct 2012 05:20:13 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Sun, 21 Oct 2012 05:20:13 -0700 (PDT)
In-Reply-To: <vpq4nm4rxsy.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208123>

On Tue, Oct 9, 2012 at 1:58 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> I would advise against the file locking, though. You ain't gonna need
>> it ;-)
>
> What do you suggest to merge Word files?

If the files are in the DOCX format you can just expand them as zip
archives and diff what's inside of them. The text in particular is
stored as XML.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
