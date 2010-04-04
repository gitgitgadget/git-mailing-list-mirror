From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: Git: relicensing test-lib.sh from GPLv2 to GPLv2+
Date: Sun, 4 Apr 2010 20:28:51 +0200
Message-ID: <t2s4c8ef71004041128s4eb66383n3f22756612bfb7ba@mail.gmail.com>
References: <87k4sq8dt9.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 04 20:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyUZ9-0005Et-Dm
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 20:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab0DDS2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 14:28:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:37163 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0DDS2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 14:28:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so492088fgg.1
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=pPOG1xSJqulUeFKqZr3KcuKGLhKXfv1G80uWwramzQs=;
        b=guBJaF8fcPRjsT6oBWyWPvKgV1JIC8qvAsHh9QzFlXUDsasPOA8cVXZnNoNJLbwFFF
         Dx2A8G0wAxry56PGx2y8CJuSYPeB/PFIHGdfBqGkjpn9BQH45z5m2vmXSNNOJfVXZOBw
         gy8TW/hWT/s57dqtwyAU4QktFeKwbTavVmQ3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SvQ9+5ffq0oedfe7UsDJXOU86dqk3n61oyJabxuWg1LgcU2dftT0pJHEmKuhdHbu9p
         R57c206lEBwgRWwWdHhPjidczp2eVE1Wjl+bOGzuu5ekeaIwHBM9GWQdilLYwwlLeQNE
         8mZBiyJ0uhclhefTSgvmLjrcM806mpmtLeMsg=
Received: by 10.239.140.138 with HTTP; Sun, 4 Apr 2010 11:28:51 -0700 (PDT)
In-Reply-To: <87k4sq8dt9.fsf@steelpick.2x.cz>
Received: by 10.239.189.141 with SMTP id t13mr420661hbh.194.1270405731877; 
	Sun, 04 Apr 2010 11:28:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143938>

Hi Michal,

On Fri, Apr 2, 2010 at 10:21, Michal Sojka <sojkam1@fel.cvut.cz> wrote:
> We would like to extend the license of that file from GPLv2 only
> license to GPLv2+ by adding the recommended "or any later version"
> clause to the license. This will give us license compatibility with
> GPLv3 projects, which would like to reuse test-lib.sh.

YES, I agree to relicense all my contributions to test-lib.sh to
GPLv2+ with the addition of the "or any later version" clause.

- Fredrik
