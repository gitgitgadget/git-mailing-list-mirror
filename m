From: "Lee Marlow" <lee.marlow@gmail.com>
Subject: Re: [PATCH 1/2] bash completion: Add '--intent-to-add' long option for 'git add'
Date: Fri, 9 Jan 2009 09:05:36 -0700
Message-ID: <7968d7490901090805w22296937n9d519591c0ec48af@mail.gmail.com>
References: <1228937958-5091-1-git-send-email-lee.marlow@gmail.com>
	 <20081210194131.GB11928@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 17:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLJt0-0005ZT-8q
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 17:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbZAIQFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 11:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbZAIQFi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 11:05:38 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:31162 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbZAIQFh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 11:05:37 -0500
Received: by wf-out-1314.google.com with SMTP id 27so9907006wfd.4
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DGrbnzLWA5oUKJ4R0UWqrq/5MOhaYko5ASHClqSNO74=;
        b=HXSuFG7f7wrD8w/ksMkTpoGuFKTC4V0aj3OpSe4eUn8xcZ3hoGfsn2Z/VloQz7Eveu
         Rds1I4B1INVTvA5pgD2Q49W0h/lO1IW2+VGqWrAPc0xAS/Otj0MLDDKg40Fmze7f/yLd
         +V74NtS+8d3W5GDtM+AtqOkcQialofdWFLtxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tvL2nCgEoLXmtAVpTMZngFatff5PgvUTTOIZguD0Kn1eScMMwCwWzoI4pk/6NfdAK2
         bHMRwtvdGUXpEl78iJ063aq3Y2mE2HikiMx1MFS9Mwlbm1OBoq+TZbuDoXhHTcS+EtyO
         V7WA34liuKuZoyvHsu3Og6K1pxEGb5Sngx15g=
Received: by 10.142.134.17 with SMTP id h17mr10762686wfd.344.1231517136562;
        Fri, 09 Jan 2009 08:05:36 -0800 (PST)
Received: by 10.143.19.9 with HTTP; Fri, 9 Jan 2009 08:05:36 -0800 (PST)
In-Reply-To: <20081210194131.GB11928@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105017>

On Wed, Dec 10, 2008 at 12:41 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Lee Marlow <lee.marlow@gmail.com> wrote:
>> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>
>

Bump :)
