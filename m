From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] revert: allow mixing "pick" and "revert" actions
Date: Tue, 10 Jan 2012 09:10:45 +0530
Message-ID: <CALkWK0mahdUKSWdeE18z4_9ubE4MY+qatzr2pCJ=0kFEWRhaHw@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-5-git-send-email-artagnon@gmail.com> <20120108194014.GI1942@burratino>
 <CALkWK0mYbBsZN1UX9YM0VWQezZsBpJCcEgKirCggtNXs0HZ-8g@mail.gmail.com>
 <20120108214042.GR1942@burratino> <20120108215510.GS1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 04:41:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkSaK-0004rD-3w
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 04:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab2AJDlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 22:41:09 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40876 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab2AJDlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 22:41:08 -0500
Received: by wgbdt14 with SMTP id dt14so2190718wgb.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 19:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PmvDY8P1o8ZeWsgcDCeXjcMdJX/xIlqqNIHto2drGCE=;
        b=H04WnyrDeGUW/LU9AdA+8v1qzrOZvvkuw1wCfiOt1IkYMoL5F0l3e0E817ifHyzqnt
         ehVq+Lo/0U/49vojErn6v+QXD68aszsiSdlnIve+G3+LLaZZ+x1zsOI5rUn0CsbLraYW
         LUhPZDBEmULuKzsJH5ujqZ/lOIFZnoAKs0DH0=
Received: by 10.180.103.2 with SMTP id fs2mr9076556wib.21.1326166866277; Mon,
 09 Jan 2012 19:41:06 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Mon, 9 Jan 2012 19:40:45 -0800 (PST)
In-Reply-To: <20120108215510.GS1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188212>

Hi Jonathan,

Jonathan Nieder wrote:
> On second thought, do you have a link to the last submitted version,
> and do you remember if there were any important changes since then?
> The base for that one should be closer to "master", I think.

There you go: http://thread.gmane.org/gmane.comp.version-control.git/186638/focus=186644

-- Ram
