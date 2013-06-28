From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: Re: [PATCH v2 0/5] git-prompt: cleaning and improvement
Date: Thu, 27 Jun 2013 22:31:57 -0300
Message-ID: <CAOz-D1JE2YkoJErY_yjvBC-YSTC=7RycB3svnQ0t3c4RMVOJPw@mail.gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com> <7v8v1vvash.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 03:32:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsNXy-0000Pt-VR
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 03:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab3F1BcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 21:32:19 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:45701 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3F1BcS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 21:32:18 -0400
Received: by mail-vc0-f173.google.com with SMTP id ht10so553595vcb.4
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lOhsZdVAgufvWv4LaCbv1oMHbfBpONbIG4mAaPYXac0=;
        b=mnUm+uYnxrIv9U0P6yTOk3j4Cg4ViF+cEHQcibNq55XEQNcJPGq9th+rY2nMfAAUGr
         Uem1FThy1lp1hkkp0EIMCEiopb9Kp90/okBlIKaSeqhyqmk20c+jZd8V4IHQDKT5RW7y
         2Xny+W7z9B6v4turp1gzWz6gVd0D12haiNlIvREJBMh8ia8d6f8If0UABd09GwpG2ZuP
         o5PqDF/PD4uf8OUuH9PODJLSAkNzh73BKpqZqKF/qAR0Iht3vznxUjsyUinpo8C0bLXC
         MO9DBz4OiaK1pcnAV+pAqbsjixEkFjj/MacPxChJ1daAUxJ+y8EvwPRXWdDDp0gSvf1+
         mdTQ==
X-Received: by 10.58.227.198 with SMTP id sc6mr4630144vec.59.1372383137927;
 Thu, 27 Jun 2013 18:32:17 -0700 (PDT)
Received: by 10.58.29.137 with HTTP; Thu, 27 Jun 2013 18:31:57 -0700 (PDT)
In-Reply-To: <7v8v1vvash.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229171>

Hi Junio,

The merged result is ok!

Thanks,

Eduardo
