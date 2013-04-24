From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] git-diff.txt: strip the leading "--" from options template
Date: Wed, 24 Apr 2013 22:14:08 +0530
Message-ID: <CALkWK0=YNcavQAEiS8-huZ98hp+FTwtU7gqQ7yaoCWA61uWo_w@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-3-git-send-email-artagnon@gmail.com> <20130424164300.GD4119@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:44:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2oP-0000Hs-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab3DXQot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:44:49 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:58735 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab3DXQot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:44:49 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so1827943iab.22
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KMrHJNKuXij5RdcOrVOJXxdSapFiPrUBOAWCB2Lt274=;
        b=rE7VklQNeM05vWKcdyZtpKKABFhjG9LqB0gXt8wZclEZqWplZnk8YpfUuZdAvJxDjM
         nj7tD0CFV/+M04AN4eGVQcIZtArswY1GKir3MrlEhQjryJPVs9l2j/T8BNqSJMC5TNiR
         mjZKiRUdeJ5WTkhIS6bxn3W1VeMRRdq+rib1FWgA1saFQs2AY1xipz18oJ/aAdHQKACk
         hblyb/JMP5i/OcxRHMq+mctPwUkpZ53WRG9aMALIFKiquZfQx256kGqHDuKGcQu3KH40
         AAQcqmRV3blHzLLNrr2nHdG7seluQBOPLhObAUdk9JoAUcowsVy/BDwIs2/8BmKT+pgr
         yW1g==
X-Received: by 10.50.57.200 with SMTP id k8mr28535347igq.44.1366821888781;
 Wed, 24 Apr 2013 09:44:48 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 09:44:08 -0700 (PDT)
In-Reply-To: <20130424164300.GD4119@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222269>

Jonathan Nieder wrote:
> Why is it imperative?

Sorry about the thinko; s/imperative/idiomatic/
