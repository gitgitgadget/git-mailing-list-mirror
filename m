From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git config' vs 'git repo-config'
Date: Sun, 4 Feb 2007 11:00:20 +0100
Message-ID: <e5bfff550702040200y4f09070fia3716ca949fddac7@mail.gmail.com>
References: <e5bfff550702040138r6580c36agf86e8f8191a40021@mail.gmail.com>
	 <7v8xfetft6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 11:00:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDeAh-0001GQ-Mc
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbXBDKAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 05:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbXBDKAX
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:00:23 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:3325 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbXBDKAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 05:00:21 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1330732nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 02:00:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EJ8BtfLUTIEsKwN7yxJf3rYX3VwSHwMSdVR9Aggqaw3jmT6m6FX/9IAw5Bmn6uz+bheMnUHu++wrZQDs6HHCiCQmSEkWzHfK/sW59a5GV4K/yQSfHmcOjspUt4uWXZmA2TrhHFTsLIgklpmBrK+v+T3kYAi8ZOfgn98OSjNpjNI=
Received: by 10.114.204.3 with SMTP id b3mr508139wag.1170583220888;
        Sun, 04 Feb 2007 02:00:20 -0800 (PST)
Received: by 10.114.61.6 with HTTP; Sun, 4 Feb 2007 02:00:20 -0800 (PST)
In-Reply-To: <7v8xfetft6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38676>

On 2/4/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Probably you already now why I'm asking this ;-)
>
> No.  But we should certainly draw up deprecation/removal
> schedule.  It simply could be "never" ;-).
>

qgit needs to handle the text codec information 'i18n.commitencoding'
