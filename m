From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 3 Oct 2006 12:15:03 +0200
Message-ID: <200610031215.03577.jnareb@gmail.com>
References: <20061002191115.84730.qmail@web31811.mail.mud.yahoo.com> <200610031018.40273.jnareb@gmail.com> <7vzmcdpwso.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 12:14:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUhIQ-0003hL-G3
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 12:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWJCKOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 06:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWJCKOj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 06:14:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:43063 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964869AbWJCKOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 06:14:38 -0400
Received: by ug-out-1314.google.com with SMTP id o38so605957ugd
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 03:14:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WmeSUwFsse3sSKcdvJIsQS6EcWDTSln8cn2vFSWqgOzsMIuycO8SgVDsD6QmGD1X3xx3Tzm39YfsRGgculOPA2ppV2Ll2ZOf5MTGPMLu8snr0C/XnXU1+MrS4JoHP30K9ESioI+HCSHvHYpFqeFbcc9iPJS0t54xSbtTGEq84Og=
Received: by 10.67.100.17 with SMTP id c17mr3581312ugm;
        Tue, 03 Oct 2006 03:14:37 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id j33sm5290398ugc.2006.10.03.03.14.36;
        Tue, 03 Oct 2006 03:14:37 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vzmcdpwso.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28265>

Junio C Hamano wrote:
> BTW,
> 
>  - why do we have shortlog and log twice in the top navigation
>    bar in commit view (a=commit)?

Huh? I don't have shortlog and log twice in top navigation bar
in commit view
  a=commit;h=e70866f53a8d31cde6cfff6396ba0d1f64029afb
in gitweb/v1.4.2.3-gd98896b

>  - sometimes I'd like to view my tags sorted by name not by
>    age.  Maybe we could add <sort-by> control on the age and
>    name columns for git_tags_body()?
Could be done.

-- 
Jakub Narebski
Poland
