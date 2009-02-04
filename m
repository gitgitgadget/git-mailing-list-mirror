From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Wed, 4 Feb 2009 09:39:00 +0200
Message-ID: <94a0d4530902032339p365df42i2b8f235430a68fd5@mail.gmail.com>
References: <1233432317.26364.5.camel@wren>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Wed Feb 04 08:40:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUcN5-0001M6-Rb
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 08:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbZBDHjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 02:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbZBDHjF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 02:39:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:43196 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbZBDHjC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 02:39:02 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1128846fgg.17
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 23:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pqz3ubkdlctImZA4oDnInejm5jGuACMcTbXXeVvx4as=;
        b=Z8lJG9e7WBgk0+zAzoOqfFnn0NWU2sQIdP0ZEI8V1jSO8HUEjgufq+LBvbwNU5pH21
         DkbZXMqUaCnlTUKXM8/9pslJkbQ7fNntmyrdxBCaLXinkh/+NFvqQWIH93d2oWZYkUvw
         yt1j6n/tAC24AH898iBzwfDoTOew3P+TZc950=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DYC9BJYyjFWQkxOyvsGSkIkSt/Fbh0Lu/6xWIHCHLhqSVEUOKRj+K96LAsWDeDP4es
         pEG9B4llKWEHIX6T7XpZOBXx8ZLNf62n57o0wLyZ8vl0YYeUZRbqiXLaqdWU4ya6NcC+
         0lBFHBiqCzbsMiIXXz6MV8qN+EFbisLQykD14=
Received: by 10.86.97.7 with SMTP id u7mr1230003fgb.8.1233733140992; Tue, 03 
	Feb 2009 23:39:00 -0800 (PST)
In-Reply-To: <1233432317.26364.5.camel@wren>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108301>

On Sat, Jan 31, 2009 at 10:05 PM, Jesse van den Kieboom
<jesse@icecrew.nl> wrote:
> Hi,
>
> I have been developing a gui application for git for gtk+/GNOME based on
> GitX (which in turn is based on gitk). I feel that it's reaching the
> point where it might potentially be useful for other people to use. It
> currently features:
>
> - Loading large repositories very fast
> - Show/browse repository history
> - Show highlighted revision diff
> - Browse file tree of a revision and export by drag and drop
> - Search in the revision history on subject, author or hash
> - Switch between history view of branches easily
> - Commit view providing per hunk stage/unstage and commit
>
> The project is currently hosted on github:
> http://github.com/jessevdk/gitg
>
> clone: git://github.com/jessevdk/gitg.git
>
> Please let me know what you think,

And the obligatory screenshots?

-- 
Felipe Contreras
