From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] qgit with tabs
Date: Fri, 19 May 2006 18:54:24 +0200
Message-ID: <e5bfff550605190954w4baab5fcj4f48a539bd120364@mail.gmail.com>
References: <e5bfff550605130344n75e3e55eq533c49fc2a4f5483@mail.gmail.com>
	 <20060513070726.qa5ssccws80go044@webmail.spamcop.net>
	 <e5bfff550605130431w417b8aacl2b17cf5655b46f31@mail.gmail.com>
	 <20060513142840.39c0kwkw84g8g88g@webmail.spamcop.net>
	 <e5bfff550605131538u63b87002o3e9b5542c0e15bf7@mail.gmail.com>
	 <1147908094.32050.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 18:54:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh8FE-000290-JD
	for gcvg-git@gmane.org; Fri, 19 May 2006 18:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWESQyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 12:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWESQyZ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 12:54:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:57072 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751333AbWESQyZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 12:54:25 -0400
Received: by wr-out-0506.google.com with SMTP id 68so981268wra
        for <git@vger.kernel.org>; Fri, 19 May 2006 09:54:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NYLnNLnQILTEDqOryivsEECPe8oOpHUVI+1NcYimAzM+qlrqfJOeQH7/z2kfoVGeQxjM8DHMJdj7TpNErlsz2uR8ddrJEBQFFa/GcgjpRcBKwsepB+afNVhxmQymkd/BTJBVRtJV0XYUYffWLKv/QYhbar0mAuWVUlnSfw9+mTA=
Received: by 10.65.237.20 with SMTP id o20mr1594873qbr;
        Fri, 19 May 2006 09:54:24 -0700 (PDT)
Received: by 10.64.131.11 with HTTP; Fri, 19 May 2006 09:54:24 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1147908094.32050.22.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20348>

On 5/18/06, Pavel Roskin <proski@gnu.org> wrote:
>
> > 3) It is true that double clicking on a revision switch to the patch
> > view at top position (if no file is selected), but it's also true that
> > you can select the file's related diff directly in patch view with a
> > single click on the right column file list.
>
> That's true.  But I still find myself double clicking on the file in the
> file list and expecting to see the patch for the file.  It's very
> natural.
>
> If I see the list of the recent patches, I see the descriptions and the
> affected files.  If I'm interested to see what changed in the file, it's
> only natural for me to double-click the corresponding entry in the list.
>

Ok. patch pushed.

Perhaps I'm not using gitk a lot so I still have to get used to this
new file double clicking behaviour.

  Marco
