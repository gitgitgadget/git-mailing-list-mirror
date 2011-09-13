From: John Szakmeister <john@szakmeister.net>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 03:51:53 -0400
Message-ID: <CAEBDL5VDsc49wj6GiQ0ZaSZ0eBy_iTd73zhgqhLfOLFhnqC-5A@mail.gmail.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
	<7vk49d5t8u.fsf@alter.siamese.dyndns.org>
	<4E6E928A.6080003@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Boaz Harrosh <bharrosh@panasas.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 09:57:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3NsQ-0000ZX-Fk
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 09:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab1IMH5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 03:57:47 -0400
Received: from mail-vw0-f52.google.com ([209.85.212.52]:34046 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188Ab1IMH5q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 03:57:46 -0400
Received: by vws16 with SMTP id 16so588291vws.11
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OrM3Jmsh9ptB+cLHjv+EKi6kgby0rC3ckNJ9o5Vf5fA=;
        b=JyZ/vGMhvrXMN9hz65Tq+xIjrpo2HqEsyVlc5JMHualEa7wR607JDMYPqoCAZBt5y3
         Vv482wrLy63wfXSzRMR7wGxm70FvL5q4SpEBPwMOHZW0k8ezU7jd9kvXzdESWMEprmwP
         CPdUV6VJqk8RQV74aq1hhjHR2cCyBdb3hSiVI=
Received: by 10.52.112.163 with SMTP id ir3mr1109486vdb.124.1315900313371;
 Tue, 13 Sep 2011 00:51:53 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Tue, 13 Sep 2011 00:51:53 -0700 (PDT)
In-Reply-To: <4E6E928A.6080003@sunshineco.com>
X-Google-Sender-Auth: lb3dysXQ1ntam9lQvyr9jkPE7Ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181273>

On Mon, Sep 12, 2011 at 7:15 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
[snip]
> Shouldn't the last entry be?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"*.m diff=3Dobjc",

Or maybe not there at all?  We tend to do quite a bit with Matlab, and
Matlab scripts also end in ".m".  Unfortunately, it bears little
resemblance to Objective-C.

-John
