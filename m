From: Frank Li <lznuaa@gmail.com>
Subject: Re: [msysGit] Re: Using VC build git (split patch)
Date: Tue, 18 Aug 2009 09:07:54 +0800
Message-ID: <1976ea660908171807x22f4b755r2e522a15ff462917@mail.gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
	 <4A899FDB.8080308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 03:08:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdDBE-0004xn-Ei
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 03:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758527AbZHRBH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 21:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758522AbZHRBH4
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 21:07:56 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:52164 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758516AbZHRBHz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 21:07:55 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1126465qwh.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 18:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OxA+VpTjQPUE9tks4V442bJzVxDNRkzw1xKTB45wZEs=;
        b=Gt5WQGjF0LZa1gUz3siGIQoqEkOH14CnJWMmO3JG1vSm/j7AF345QYlbk28gFu6xvJ
         bJDk6SSz1cjnk0QW38CLFKh2SZYTnxBLjEocCGhSrgcTfz8CJAQUDNJ5nuSdKMGgJaKE
         8KtVnn/VgfRbF6Wc7Ob8TKEHCtqw95QROU5pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qw4N/yCUl7+r+yXYbI2n/Te6DqOJYzNcmE6t7bAMMswao7ommhqQ7AfU5ufFrUwE76
         9k3JO3qDVXfo+xq7uT54HeM1rS5cP+Z3jcCOR0yw03sMIMUcN8DneOwGY/hT8Ti7xhpr
         PTpo8pv+q8eBHewj+Po1i/smUXyxXEgx3TzUM=
Received: by 10.224.123.198 with SMTP id q6mr4902221qar.209.1250557674682; 
	Mon, 17 Aug 2009 18:07:54 -0700 (PDT)
In-Reply-To: <4A899FDB.8080308@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126334>

> Hi Frank,
>
> Could you please also update your repo at repo.or.cz, then it'll be
> easier if anyone wants to help you in the process of streamlining the
> patch series?
>

It seems network problem yesterday, I can't push anything to
repo.or.cz. I will try today.
