From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: How to ignore a modified file?
Date: Thu, 5 Mar 2009 11:09:45 +0100
Message-ID: <fabb9a1e0903050209i1e70c8b3n69d7ade9e382b617@mail.gmail.com>
References: <20090305145308.6117@qkholland.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dealmaker <vinkhc@gmail.com>, git@vger.kernel.org
To: Quim K Holland <qkholland@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAXt-0007sV-LX
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbZCEKJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753940AbZCEKJu
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:09:50 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:53493 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbZCEKJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:09:49 -0500
Received: by bwz26 with SMTP id 26so3175930bwz.37
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 02:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JQve62XOa+rBPs9UsCLJ4RreQORJCLVnbvpI4tySoEE=;
        b=OFCWFPS6BZ8WKC/n8ZsDQfFqubFpgHPSShe9LLgXldyiVM04Tj1GFB39U6LlxVTQLP
         +KgRK5Pb4HugVfMABYQl6+O9uwgDiLOdgaqF9iPlpvTY+5ghUam/f/5em0qhH83vpczV
         YEyi6KuAsM2zGGxrLp6DS6bYixP1OzBo6VXz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xbe8bsoxaOxvO87K5IaBp/SitGbiD/MPd/DuTkq+AyNAkuB13icDspVP53MVLDCES6
         sqtLweVQgXx1w1DWquU/dxnHVGk2Uueu5CJ19KNYtVvZHkjgMZOVgdenowAq+Abb1eom
         GBREhQfJjUtNRpdFmbRPVrs7LEi8m7QDgdai4=
Received: by 10.103.174.16 with SMTP id b16mr462545mup.28.1236247785124; Thu, 
	05 Mar 2009 02:09:45 -0800 (PST)
In-Reply-To: <20090305145308.6117@qkholland.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112284>

Heya,

On Thu, Mar 5, 2009 at 09:53, Quim K Holland <qkholland@gmail.com> wrote:
> You can run "git checkout directory".

Yes, but that would destroy his changes, I do not get the impression
that that's what he wants...

-- 
Cheers,

Sverre Rabbelier
