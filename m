From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: multiple .gitignore-s
Date: Mon, 23 Apr 2007 13:51:48 +0300
Message-ID: <f36b08ee0704230351l19eae2dbl3e1ce7287658be06@mail.gmail.com>
References: <f36b08ee0704221436g661396b6m4ed8e16676175f4a@mail.gmail.com>
	 <7vwt04krp8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 23 12:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfw9H-0000Bs-Jr
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 12:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161364AbXDWKvu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 06:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbXDWKvu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 06:51:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:23910 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161364AbXDWKvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 06:51:49 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1738121wxd
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 03:51:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GmEBtVsVVfDcRkRejax85f02+vSsnwsm/WBGk1Ti0Qiec0weDYxvnZqFMa5hBGm0JQmyJBRHSc+3ftVM5czrfuewaESjRHxI5eiQvZo7wb/W3Degg8gZC6qo3/+yphxhO/MShh+IODJQeOaGK5B3c9ghXLumMmc9B8KkDerRNMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rnn/YHNMdKzEk/0+M1pkXOQaU4QT4ZcM/a6v+UZySs0d31n1JYVDwNXgNf9tCVBb93wpJ6ea1TxmltGnGoHt+ounoYspE26MCPtnNP2UQf7ug5YjxndTGrxcYmyrIQOUIYLeJBxGh671EZRP4gEicBNZj4KzNse8vyVhUAfTRuk=
Received: by 10.90.49.1 with SMTP id w1mr483418agw.1177325508505;
        Mon, 23 Apr 2007 03:51:48 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Mon, 23 Apr 2007 03:51:48 -0700 (PDT)
In-Reply-To: <7vwt04krp8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45314>

On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
> "Yakov Lerner" <iler.ml@gmail.com> writes:
>
> > If repo has toplevel .gitignore, and subdir A/B
> > has also .gitignore, then how these two .gitignore-s
> > interact to affect A/B ? Are they shadowed, or accumulated ?
>
> Study "Exclude Patterns" section of git-ls-files documentation,
> perhaps?

Thanks
Yakov
