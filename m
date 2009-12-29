From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Help on CGIT
Date: Tue, 29 Dec 2009 16:58:36 +0200
Message-ID: <94a0d4530912290658m70075ad1u95e3692c01fb44b7@mail.gmail.com>
References: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jorge Bastos <mysql.jorge@decimal.pt>
X-From: git-owner@vger.kernel.org Tue Dec 29 15:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPdX0-0004Ww-C7
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 15:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbZL2O6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 09:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbZL2O6i
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 09:58:38 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:63412 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbZL2O6h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 09:58:37 -0500
Received: by iwn1 with SMTP id 1so7895180iwn.33
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=h4jG+JIr14S0Atqc8VjhV7k73Y16f//Y617OuDo66/w=;
        b=ojHzKXqndat+GiiIXfL8QFuHneOXfCMbbQaxLHVxx0/W+KDLpg2DrGuadYziY+Tvei
         rkAORkO8UtEBqkVjM2MVRNwT1NlWziEGilyLcM5b0b8TJuTTTaJW8iUlmEfhuj9hFObt
         sHQxRZ6RNX2SrM/E1k+ZdkRhfcxXLPV9mJIYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H2tMdUanVkFX7IFQ9erOuFuG7UsuSobEW9YHVE9arU2pBEqf3zs8Lm6ieEo2XCSYYx
         3DlzyUV2EW1LPoFt5C/owE+z3Her3j2JEJ1+qB483KdyD2UbtqFzrjLW6SQ3D7ltO035
         9Rcs7+E4QjiHwxVTGZATqmpAmDK5mM7VJbpUs=
Received: by 10.231.153.69 with SMTP id j5mr1138486ibw.33.1262098716998; Tue, 
	29 Dec 2009 06:58:36 -0800 (PST)
In-Reply-To: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135802>

On Tue, Dec 29, 2009 at 2:18 PM, Jorge Bastos <mysql.jorge@decimal.pt> wrote:
> Am i missing something else? I've asked google but there's not much info
> on the web about it.

This is what I do:
ScriptAlias /cgit /var/www/cgit-files/cgit.cgi

You need a new cgit to use that properly, I use 0.8.3.

-- 
Felipe Contreras
