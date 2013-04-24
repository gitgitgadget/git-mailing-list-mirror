From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] git-diff.txt: group the [--] and [<path>...] templates
Date: Thu, 25 Apr 2013 00:54:01 +0530
Message-ID: <CALkWK0kUmtXhEf90cs4yEj8_9FvxhDGZKS2crE6f-bpwrJ0fYg@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-4-git-send-email-artagnon@gmail.com> <7vtxmvdc4d.fsf@alter.siamese.dyndns.org>
 <CALkWK0nU-iTSF2DnmJAB=kj6w+VFv3rQrixEnHz0vyXf2d2=Mw@mail.gmail.com>
 <7vbo93db25.fsf@alter.siamese.dyndns.org> <CALkWK0nN+9XOTCqiY+yB9moQSvFFpSO=OZjJtLphBd2eQ24uDw@mail.gmail.com>
 <7vy5c7buqn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5J8-0001ag-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab3DXTYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:24:42 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:39705 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797Ab3DXTYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:24:41 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so2616080iea.18
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aKm81KucLA72T3s+iNsOQ57uqdHu+H6DnnhxsN4hP0A=;
        b=pgwhXp8tM5LogzmShLaCREl5oP1YzbLsNzZdNraEgUY5T5k+rWMQOutoQsaAuAlFPF
         6BeLrQJ4VUUcIzQkpSsdNiwcavVKT8ldF+Q1u04Pm7vAqk/gOCH2LSaXWHLyKe2pLDYU
         1z3Qw/2QFksGLDp35KiiZZmrUNpYaoACQrmcNxVA7TEJzP24cNVA6KB7WnNXE0bjf6h7
         dKWNqtMS4vwGP4bpopJzbL1c0E9kfhgUWIGm73g1a0wMQt/Jbk39vA6sm/Wpx4lI/HJO
         9iNYHodsOuxIJp+ag31E6yNdoAzjmeQtRlyUnUbNEfQHc0SWKvmAa/rlYXwpNyokjEef
         TAhw==
X-Received: by 10.42.27.146 with SMTP id j18mr8409824icc.54.1366831481363;
 Wed, 24 Apr 2013 12:24:41 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 12:24:01 -0700 (PDT)
In-Reply-To: <7vy5c7buqn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222306>

Junio C Hamano wrote:
> You are missing the entire point.

Yeah, okay: I'll drop this patch.  I was just saying; I don't feel
strongly about it at all.
