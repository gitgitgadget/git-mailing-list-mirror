From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [ANNOUNCE] L10n update for Git 1.7.10-rc0
Date: Thu, 8 Mar 2012 20:51:03 +0800
Message-ID: <CANYiYbFstNf2a5xGMHcfZcm=M_4xzKO_yTOed9cBoJ9uFx4H_Q@mail.gmail.com>
References: <CANYiYbHrhcmURri+Lg7_K3XXhYZsjF7SkCzUsgvHgjBvgNKDAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Mar 08 13:51:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5coH-0001mq-UW
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584Ab2CHMvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 07:51:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40314 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab2CHMvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 07:51:04 -0500
Received: by yenl12 with SMTP id l12so145742yen.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 04:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=NIzEjmkes05b6MLBhWtXOarThB+8+r5k++MEW5+8jjc=;
        b=zOb2UOO0i+CDhRVqaVF/RPM9Htn+7glMz1gE+lPGBUQJCUT0xaHuaVMqYNAlgCioyz
         cf2b5ZODgkvHMyNwOAAQ4U+v2z8l5UWuuKwrBvOdqSFlo6/oj8urqTfGhx+dnwD4W6Lk
         EXL4d0u/zzprJ+vsQIiQbMxuF7NPoJAVvoLek6ewuc4L52mmtuvz2WopP5eSN9fbEwqL
         o9SZtjsj+iL8yAoz2h+6MtXj8k4NmDsxk+zDOLMTECCjvZgcoSoD0QDTdCDE50qmbq2f
         rN+2hDzjoeUUG4yuFzFfTiZas1htaaXmJ5Pk5qimpZ9Ud+ewKJadxB2UmAOd2WWkqK6a
         CxBQ==
Received: by 10.236.195.37 with SMTP id o25mr10360525yhn.55.1331211063553;
 Thu, 08 Mar 2012 04:51:03 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Thu, 8 Mar 2012 04:51:03 -0800 (PST)
In-Reply-To: <CANYiYbHrhcmURri+Lg7_K3XXhYZsjF7SkCzUsgvHgjBvgNKDAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192589>

Peter Krefting (nafmo) offered Swedish translation, and Git can speak
Swedish now.
Peter also create the first l10n team since the git l10n workflow
taken into practice.

Pull request from nafmo: https://github.com/git-l10n/git-po/pull/5

-- 
Jiang Xin
