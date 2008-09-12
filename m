From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: Git on server
Date: Fri, 12 Sep 2008 07:55:50 -0700
Message-ID: <1621f9fa0809120755g1f9b4be1g4f88e47cda866c77@mail.gmail.com>
References: <19440690.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: delux <jared@2ndnaturestudio.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 16:57:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeA4y-0006jw-Q3
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 16:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYILOzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 10:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbYILOzx
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 10:55:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:44482 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbYILOzw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 10:55:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so323681ywe.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zG/amZ700WJpUKZSqE2S9CIZ4pkqvxfzGaXV3X3ssdU=;
        b=annJZYCfDd4lH7gq8LYMcgs7bnC0fTNj87dsHNoGuD3GCJ0yVvJeBeDL20l4GYvWFQ
         UpwNwBuzEWn9PRAjq4MC4jucKXIPh72v5MmeNbCAmpn7qQqdE8L66co1Cs+5x3VR0MaS
         h8ePbHsXGNe73jXkpxT4R9zFKaWOc7pnjaMwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=F7OYrM3azCPVfO870xRveul/0esy+ydjtD8ojb8PPxEfDW7gUpqvQrOaphZxHRs6YE
         YQfwYgGScLV4802PriqCkV2HhjNWzCGSS1ljVjYN+tSzKRT1p5CDFsPAKaqj1qCjufj4
         GmcjLmCWm48IRQzGXDSk/wmCABuv1TMOn3mL4=
Received: by 10.150.144.9 with SMTP id r9mr6151732ybd.192.1221231350845;
        Fri, 12 Sep 2008 07:55:50 -0700 (PDT)
Received: by 10.150.228.18 with HTTP; Fri, 12 Sep 2008 07:55:50 -0700 (PDT)
In-Reply-To: <19440690.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95729>

On Thu, Sep 11, 2008 at 10:57 AM, delux <jared@2ndnaturestudio.com> wrote:
>
> I work in a studio and we have many projects that we work on. We want to
> start using git, but we seem to be having some problems. I need to be able
> to pull the files from the server on to the local machines or have user
> repositories where the employees can pull the files to their repositories
> work on them then push the back to the main repository. I have tried to
> create a main repository and user repositories to try and push and pull
> between them and had no luck, git is installed on a Linux server and we have
> Mac and Windows machines. Any help is greatly appreciated and if more info
> is needed please let me know. Thanks in advance!
> --

http://www.kernel.org/pub/software/scm/git/docs/everyday.html

Look for
""" CVS-style shared repository. """



> View this message in context: http://www.nabble.com/Git-on-server-tp19440690p19440690.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
