From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 00:34:05 +0200
Message-ID: <4ac8254d0904191534q3abc4bdq7aebb0559803739@mail.gmail.com>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> 
	<4ac8254d0904191510v72ab2f92t6839c8354d0c6fe4@mail.gmail.com> 
	<alpine.DEB.1.00.0904200028340.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 00:36:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvfcJ-0000y1-SI
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 00:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbZDSWeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 18:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbZDSWeW
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 18:34:22 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:45147 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZDSWeV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 18:34:21 -0400
Received: by ewy24 with SMTP id 24so934275ewy.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EN1SXXDnsu+2n6vsFCC3ZnMhf2CUE7vugQSLa3RBK2g=;
        b=N2yHg+/qhqUp7GUdbDqBZTD6sNCCfAkTZBFcM75LSd8QgylhERpFFSVaj6fsVu3oxP
         6YOjpvkH1eIblhy6Dkfo4L3joIOlDn1tuQrcEE17bXovYEbzBuk2rdP3Qmt+C0EBjI59
         2ZjqEFHB4LKBbXRlWI8NfuXTW8waXphpewNZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XYu7xSDXww3KvHiA9dhjUGx3L+CJGIiZ8gJEOK2iwruV8HLrpdu23Q0JhtyeKd7hd7
         aoluLioanDFFC2rvJJt06/gQMEFyvOW00r/ay5OTmJH6bMh0RXVqY7tgMmDPaTpPW3j7
         GpkhmfaoP9Q9mODXZ2UeSdNm8SwZMN601B07g=
Received: by 10.210.126.18 with SMTP id y18mr5130531ebc.45.1240180460093; Sun, 
	19 Apr 2009 15:34:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904200028340.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116916>

On Mon, Apr 20, 2009 at 12:29 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 20 Apr 2009, Tuncer Ayaz wrote:
>
>> On Sun, Apr 19, 2009 at 5:17 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > if you're like me, you used Git for _way_ too long to really
>> > understand how anybody can say that Git is hard to learn. =A0The
>> > concepts underlying Git have sunk so deep that I do not question t=
hem
>> > anymore.
>> >
>> > But it is important to keep in mind that our concept of branches i=
s
>> > not intuitive:
>> >
>> > http://longair.net/blog/2009/04/16/git-fetch-and-merge/
>> >
>> > In particular, we have some pretty confusing nomenclature when it
>> > comes to branches, and we might want to think how to improve the
>> > situation.
>> >
>> > Food for thought on a lazy Sunday afternoon.
>>
>> Probably in the same confusion department:
>> http://blog.teksol.info/2009/04/15/beware-of-gits-content-tracking.h=
tml
>>
>> Is he right and is this the defined correct behavior?
>
> Could you please at least change the subject to something like "Somet=
hing
> else, was Re: ..." when you abduct the thread?

sorry, will repost. I have to admit that I was 25% unsure whether
this is related and the right/wrong context. oh and that number is
exact :).
