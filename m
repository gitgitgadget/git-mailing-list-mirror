From: Andreas Ericsson <ae@op5.se>
Subject: Re: introduction
Date: Tue, 05 Jun 2012 11:40:16 +0200
Message-ID: <4FCDD400.4020003@op5.se>
References: <CAA3EhHJCRF05Q0xzzOWupVMjmKPbWAq1KNcU9Mmp8g1iH2B0zA@mail.gmail.com> <CAA3EhH+P_JeVGhRmL-kHOc0cTCiGQmv505XjgAv0kT1PAfjTyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:40:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbqFc-0001yS-8r
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 11:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761557Ab2FEJkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 05:40:24 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33868 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898Ab2FEJkU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 05:40:20 -0400
Received: by lbbgm6 with SMTP id gm6so3734579lbb.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 02:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=vrSb9J4CaFHA/7cBemBu+q4/mJ6zgDs4S9cBdSfGJxM=;
        b=lNKKAVfHFe+x2y/+w/Yl8VX9FXmo3gHbAAl3qqtO34L0zaJR9ZvEmwCJIlcR4Qj7Wp
         E5k0jzfOHVKOQ3B+FM+ZenGIzqv5F59H9PokybtBJm1Kf/l6/vkqSTxbAF7EmDh3HlKe
         ZWIB93a5iajEI85NoCfB4lZbeMzEieSXhWuwscVgJm2gEeURvAe3o6XigIQWqOaAYyD+
         CUm/RmxpstWlbqc6x5ryP8+8ZaJq2nTd0aN1tlX/G9owjZkTQecUnWOKHqEFAhSI+MKO
         g2Kxg3F1yEyKs/swlaDvoQU9bI6pO/uprOMLU6UDIDDf+gYfvu4NBqbnb83JvT69pJyl
         qoQA==
Received: by 10.112.32.35 with SMTP id f3mr7633882lbi.47.1338889218156;
        Tue, 05 Jun 2012 02:40:18 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id q8sm835495lbj.2.2012.06.05.02.40.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jun 2012 02:40:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CAA3EhH+P_JeVGhRmL-kHOc0cTCiGQmv505XjgAv0kT1PAfjTyw@mail.gmail.com>
X-Gm-Message-State: ALoCoQmdMT44Xiro1q4MBuTMiiw3HNv8ULzK+XJ4bnDLsNJ6bBxrf3ZAOFWn0oV3nm2kEGj5b7F6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199225>

On 06/04/2012 10:36 PM, Leila wrote:
> 
> 3) Just like we have git-svn, maybe a svn-git?
> 

I would absolutely love "gvn" command that works more or less exactly
like svn, but works against a git repository instead. That might allow
me to persuade the last recalcitrant bugger to switch to a version
control that actually allows people to work *with* the tool instead of
*for* it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
