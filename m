From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sat, 26 Aug 2006 07:34:34 +0200
Message-ID: <e5bfff550608252234u6d4e9efax8ca7e2225cef4cef@mail.gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
	 <200608252135.27894.jnareb@gmail.com>
	 <e5bfff550608251433o36713ee1na5544992320b5845@mail.gmail.com>
	 <7vveog45ff.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550608252144p2d234a7cnf2ca2922c98d921b@mail.gmail.com>
	 <7vejv43wq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 07:34:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGqoi-0006u6-Rs
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 07:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWHZFef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 01:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWHZFef
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 01:34:35 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:6679 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964879AbWHZFee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 01:34:34 -0400
Received: by py-out-1112.google.com with SMTP id n25so1548243pyg
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 22:34:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nfCKloOnC/03go+6IefJq4jmIokHPDnAQT+03YuaLKGJcHywjq6vEqi6jBKRJ11hegtjhPKvEnXXo2I1hZzWrHOgypXO4/1PTkxwzRVY803ab2RzDpsUqZ2Jheslp449ZZGggmnxsTN/AlBXTWmkAJUOtNjmoPBfjplYI2GAE9Y=
Received: by 10.35.36.13 with SMTP id o13mr6740882pyj;
        Fri, 25 Aug 2006 22:34:34 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Fri, 25 Aug 2006 22:34:33 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vejv43wq9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26030>

> Actually Linux git archive _is_ a special, odd-ball case.

It's also our main customer ;-)
