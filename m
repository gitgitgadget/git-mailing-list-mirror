From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 1 Feb 2010 13:27:58 -0500
Message-ID: <76718491002011027m763c8953k12f7cdd4324c8672@mail.gmail.com>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
	 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1002011309020.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steve Diver <squelch2@googlemail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:28:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc10N-0000tQ-J8
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 19:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab0BAS2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 13:28:00 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:57255 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0BAS17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 13:27:59 -0500
Received: by iwn16 with SMTP id 16so69940iwn.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 10:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=XDXxoVGEKSx3Z1b5kIqBEIu9NgT1k7tiWZTi7Ujek/I=;
        b=MljxLR7zurVkR858RT3iCA30d201yry9EzTRvj+hrqtE0rmcBH7McuyLbX4ooJK5GH
         FA1MsvrdAlh1mc70S2fDaNutPPqVvFu4q+/C1ZqCBMwpuia26dZe9PWZ7LuYCtdV8LM6
         TSEdO0yMRWGtkSpFZQ0dCnsdJWjaCHgWJIyIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=oraQkA5Ta5uyUezU8dWMTZEFciGOV+ZT/zbUPj0TdFWPLbCOubDkOsMEekNUGg5OeY
         QbJZ+jKGO+Dt4aiagwTwPKEKF4p7zpsyqvl0Yhtf5yAfA93zIJLvvndSVN0xlW6hb90M
         HKJq35X3RUk3qz/3p/zeljoaZEiBCfeekj3W0=
Received: by 10.231.167.204 with SMTP id r12mr4384604iby.31.1265048878259; 
	Mon, 01 Feb 2010 10:27:58 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002011309020.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138639>

On Mon, Feb 1, 2010 at 1:12 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> I thought that a documentation update in this area was already planned?
>
> Jay Soffian (added to CC) agreed to augment the documentation with the
> comprehensive explanation he posted to the list lately.

I talked to him, he didn't forget, and he'll try his best to submit a
patch this week. :-)

j.
