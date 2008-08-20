From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Wed, 20 Aug 2008 13:34:39 +0200
Message-ID: <81b0412b0808200434j64fb97c9l64cfba62f179d99a@mail.gmail.com>
References: <200807230325.04184.jnareb@gmail.com>
	 <200808200308.26308.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Stephan Beyer" <s-beyer@gmx.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 13:36:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVlyc-00089e-4i
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 13:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYHTLel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 07:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbYHTLel
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 07:34:41 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:41586 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYHTLek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 07:34:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so511129wfd.4
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CjKY3Ncs/eDJrSpojm933PBpIQndHK1JzuHTuczAqfM=;
        b=DietYAdN5YiqT64UJzIB6TJzp9RpgsPbbfJsSY8osNfVXt/gnJ3A72uiFDFbwAHxIH
         mEA3fJadQUCnZUUdtq1EXzGLRS6l6cqHO/Ty+l1cvdd3m18xYQlecWk3MJHSlegxuLkw
         0KK7ziFb2MTHZu7W5/Yh86KqRwV18GfS/6xew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nwFnjFF1DhvHAgGGYKZkUnXnKinJYVYbpZkPsk+Xy7pkamWU0z/0Wdq436eeiR60kv
         rnIS8HkLQvm7uqAOgqmG2Tm93eiFPAAQMP4RroFkzhylw/P5ochlV9PQXnJBnxfE5dOr
         B6TAeVJk1KyjW2R71WRagghtJlHuVGY+i1upc=
Received: by 10.142.142.14 with SMTP id p14mr4213wfd.114.1219232079596;
        Wed, 20 Aug 2008 04:34:39 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Wed, 20 Aug 2008 04:34:39 -0700 (PDT)
In-Reply-To: <200808200308.26308.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92980>

2008/8/20 Jakub Narebski <jnareb@gmail.com>:
> About you
>
>   xx. What country are you in?
>       (free form; it would be nice to have pre-filled pull-down
>        menu, i.e. select form.  Survs.com doesn't support it, yet)
>   xx. How old are you (in years)?
>       (free form, integer)
>   xx. Which programming languages you are proficient with?

"Which programming languages ARE you proficient with?"

or maybe simplier

"What programming languages do you use?"

>   xx. How often do you use the following forms of git commands or extra
>       git tools?

Some time back there was a script posted on this list which extracted
this statistics from users .bash_history. Maybe reference it here?

>   xx. Which features do you find unique and useful ones, compared
>       to other systems (other SCMs)?

The meanings of "unique" and "useful" are unrelated, maybe make this
two separate questions?

>   xx. If you use some important Git features not mentioned above,
>       what are those?

"What, in your opinion important, Git feature it is not mentioned above?"

>   xx. What would you most like to see improved about Git?

you can drop "most": if people think something should be improved,
we (most) likely want to know about it :)

>   xx. What tools would you like to see Git support in?

"What tools (IDE, RAD, editors) would you like to support Git?"

>   xx. Did you have problems getting GIT help on mailing list or
>       on IRC channel? What were it? What could be improved?

What they (the problems, plural) were?
