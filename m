From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Quick question: end of lines
Date: Wed, 1 Mar 2006 09:15:53 +1300
Message-ID: <46a038f90602281215n259066b1qe2e6421625b82e75@mail.gmail.com>
References: <f898cca90602281032n6603bf14q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 21:16:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEBGK-0000hw-3I
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 21:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWB1UP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 15:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWB1UP5
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 15:15:57 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:22698 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932550AbWB1UP5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 15:15:57 -0500
Received: by wproxy.gmail.com with SMTP id i34so1187068wra
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 12:15:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hg8JndCRChmd9aWd0TzT0KiQB/xIonS9TZN5Q5/eofS4+51ZMp872BbYX2FPx+6T9XsfcpmqnaPuWjJP3Y/1bxPF56HIMFSLvRZmXOCAsmEHJoJJ1Iq4TDenmOquZlv5FOUOZ4jXC+ySb9YH5f8g2fkUpONM0fUq3YyD5qyydRI=
Received: by 10.54.66.13 with SMTP id o13mr1058808wra;
        Tue, 28 Feb 2006 12:15:53 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Tue, 28 Feb 2006 12:15:53 -0800 (PST)
To: "Emmanuel Guerin" <emmanuel@guerin.fr.eu.org>
In-Reply-To: <f898cca90602281032n6603bf14q@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16951>

On 3/1/06, Emmanuel Guerin <emmanuel@guerin.fr.eu.org> wrote:
> To be more precise, I need to be able to checkout files on Unix and
> Windows, and it is important that the end of lines are set
> accordingly.

Why is this important?

(I am thinking: any reasonably good text editor will know how to deal
with unix newlines, but you may have different reasons).


martin
