From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] git-svn: add --ignore-paths option for fetching
Date: Sun, 25 Jan 2009 21:41:04 +0100
Message-ID: <bd6139dc0901251241g423d4fbdk323ea97ac79eb2a3@mail.gmail.com>
References: <1232912944-27076-1-git-send-email-public_vi@tut.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: trast@student.ethz.ch, git@vger.kernel.org
To: Vitaly _Vi Shukela <public_vi@tut.by>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBoP-0002TM-H6
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbZAYUlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZAYUlH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:41:07 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:54607 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbZAYUlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:41:06 -0500
Received: by gxk14 with SMTP id 14so4952098gxk.13
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=/opusE8fgXp6Ln4B81zE4EBusbq1iipYOc7PqN0JcMc=;
        b=hZRdjwjS8Av7O2Z9K2gkXCK+43IAPtbqVVoinEbLZ8NJzrtF8nbVQg6Ns1MXuwRVuz
         W5bpQhZ2hxuXtxJUxCbEWtziCnW7yayymh1iQMMvoQzOnEqZbkWWRuXm1QKTQY93+1Sa
         S3R4Rd82YA968WOLYuhwAE//3kCtcQSPaeObs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=L9k9is1xL+OkjDBOpCfg/nR3RHjxeTOpxlogIRMOMFNcbMEH0DqPexFUCksGhDVlbJ
         kYiXH4dSArH6U4lxDltWuHnDrDTPmsMzI7JaO0vZZ0ZYPl/0Y/2A71SeLGDX3swffZ3N
         NtlrpdHCFSVSx7KuBMcY5g6Z0ueolC2bpmPO0=
Received: by 10.151.147.16 with SMTP id z16mr83353ybn.52.1232916064478; Sun, 
	25 Jan 2009 12:41:04 -0800 (PST)
In-Reply-To: <1232912944-27076-1-git-send-email-public_vi@tut.by>
X-Google-Sender-Auth: 139840f0d1b800bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107100>

On Sun, Jan 25, 2009 at 20:49, Vitaly _Vi Shukela <public_vi@tut.by> wrote:
>
> Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>

You still did not explain _in your commit message_ why it would be
useful to have, which is what Thomas asked for ;).

-- 
Cheers,

Sverre Rabbelier
