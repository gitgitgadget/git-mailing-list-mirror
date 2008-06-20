From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Are C++ contributions welcome?
Date: Fri, 20 Jun 2008 17:30:31 +0200
Message-ID: <bd6139dc0806200830h633c954bn6dbfc87ada90756b@mail.gmail.com>
References: <4c88165dd0077363a30b4f98fed16c2f@localhost>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "jose maria gomez vergara" <josemaria@jmgv.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 17:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9iaG-0005EU-PY
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 17:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbYFTPad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 11:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756739AbYFTPad
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 11:30:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:60839 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715AbYFTPac (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 11:30:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so986228wfd.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fRZGISgStnfXzhKVBw9hot+XgyiHdH0AxMisxyUSfZQ=;
        b=BulSLu/FFmCFjbHxDrZ0P3/w1qBtMyC7UzLnqFlkfc1Nr8FHo8zOFP8GcOi7w+QpgQ
         rxn4DufWk8tes8AvJzeiYxRDxorv/dAlUveIE1EswZ/Yetc0bD2fghDiA9AawmFFe+Mc
         wDgKGoPv9k2eoBnD7d9rSmzCUJH1oW3HQHE+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=KJTS/9c8XLkUyWToeKwDbN30rDsbuCnz7K2+guk+4ZEHaJ4GEOzjOKOjliQCM1CmOp
         Wa6fQPQCZViPf+AWYmrZoKS7RXEfRBaozQKHzZjCPEccxiRjt7t7O68T6L3Ji8X/OcXr
         VUWI4S5tu07bSo7cF+nzoaiFyc0FZqZk/rT/c=
Received: by 10.142.153.8 with SMTP id a8mr1358920wfe.316.1213975831338;
        Fri, 20 Jun 2008 08:30:31 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 20 Jun 2008 08:30:31 -0700 (PDT)
In-Reply-To: <4c88165dd0077363a30b4f98fed16c2f@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85653>

On Fri, Jun 20, 2008 at 2:23 PM, jose maria gomez vergara
<josemaria@jmgv.org> wrote:
> I don't feel comfortable programing in C and I prefer C++ only because I
> have more experience using this one. May I contribute to this project in
> that language?.

Any programmer can learn a new language as long as they have enough
programming skills; it's not the language you are proficient in, it is
the programming you are proficient in. If you would like to contribute
to git, consider polishing up your C, really it is not all that hard
;). The main thing you will probably stumble into is the lack of
std::string, but there are plenty examples in the git codebase to
learn how git handles string.

-- 
Cheers,

Sverre Rabbelier
