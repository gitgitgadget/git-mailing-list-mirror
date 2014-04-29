From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 19:59:17 -0500
Message-ID: <535ef965e15dd_5f0313212ec3d@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
 <535e8e4253196_45651483310b3@nysa.notmuch>
 <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
 <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
 <xmqqk3a9m3ah.fsf@gitster.dls.corp.google.com>
 <535ee95fc17d5_5a07e812f018@nysa.notmuch>
 <xmqqfvkxm1wc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: James Denholm <nod.helm@gmail.com>, David Kastrup <dak@gnu.org>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 03:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WewYX-00013y-0m
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 03:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbaD2BJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 21:09:53 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:37272 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248AbaD2BJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 21:09:52 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so8132139obc.24
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 18:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=efF6a0+wBPgclofko/o6B2VJ2c+5+IIWcO66omw4QlQ=;
        b=v+fcm7uL+hZVNYnpOQETMnYs61o6hknRlxstApN/MRorYND+Xr/TqkmZJNKT3u7il+
         ldUHMzaQhUgo2hdGtO8hZq7oyakN1KcIBp5g8VebdSQ4ASwFT4SSUcT/JeeLwmzaB78X
         eZBxKXMvk+EEEg+ERENPKWJrjQNHKUVw8p/TYmwEo5nlCV7AT9PvP1qAcR/EvwFVKrB1
         H5UVuCxYnjjhIOGFdH/C9fuSXicoLFd86CcQ98ots4MvgrMvRtdroOQfVVUeWkMG+Io2
         avdQmbsoaHhia1Tz45BBfnam2NEALh01rV/xgHxCd3DqfgEAhdFAIFOxlHh29e108WGF
         +a4g==
X-Received: by 10.60.95.230 with SMTP id dn6mr25025802oeb.25.1398733792095;
        Mon, 28 Apr 2014 18:09:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm40450760obk.4.2014.04.28.18.09.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 18:09:51 -0700 (PDT)
In-Reply-To: <xmqqfvkxm1wc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247505>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > In this context James was talking about what Git should be. But the vast
> > majority agree on this issue, so that's not what's preventing change.
> 
> I agree that recognition of the issue is not what prevents a change.

It's not just recognition of the issue, the solution is agreed too: change the
default. The specifics of exactly how might not be.

-- 
Felipe Contreras
