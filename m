From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: help moving boost.org to git
Date: Mon, 5 Jul 2010 20:43:48 +0200
Message-ID: <AANLkTilwCsMLy7jyKFoRLu07HW6E3C76Kmkm4UVg6OBU@mail.gmail.com>
References: <4C31E944.30801@boostpro.com> <4C31F0D4.1040207@viscovery.net> 
	<4C321BAF.8020303@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Eric Niebler <eric@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 20:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVqeO-0005oi-9B
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 20:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab0GESoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 14:44:11 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54907 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab0GESoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 14:44:09 -0400
Received: by gxk23 with SMTP id 23so2595903gxk.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=bkwp2oRdOMFHivtGlMhzbUvoKlRh0aQ0ZDyPpVO5HKk=;
        b=H+xWxfCZxMWoNcFUTZ3hGUTMadxppvGF8Nzhldi9+1RiPSKo/XQlWrcy1nGjUS7lLb
         HKiZkoK6nvairYcieGt6gwQ4JUHC3hcTbmZ0kZ4ibzajAVN0p4/pGPocDwXVrGjhevoa
         26EdDhS9BjwPPzUySio66bI9uHbH6ZfgROWkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BOrQ36lLWnuPh27OGUlmIszGV9RPeqSCyHGAxNbiOMX2DtdAjmsFyPTSfYJdjKIVeo
         +KymGXSyG/fe0Bz2ZzkXml85oeNx7GAdW27Khe3MGfWk871BA7UaniKr0y51TIcYjO1z
         lHjJOJA1mxuC4pPZg3t5c1VAQSCuVT8+G59Rs=
Received: by 10.101.160.30 with SMTP id m30mr3998376ano.196.1278355448502; 
	Mon, 05 Jul 2010 11:44:08 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Mon, 5 Jul 2010 11:43:48 -0700 (PDT)
In-Reply-To: <4C321BAF.8020303@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150284>

Heya,

On Mon, Jul 5, 2010 at 19:51, Eric Niebler <eric@boostpro.com> wrote:

> I'm off to learn about filter-branch, tree-filter and svn2git. Thanks
> for the suggestions. More questions to come, I'm sure.

Also have a look at git-subtree.

-- 
Cheers,

Sverre Rabbelier
