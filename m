From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: German translation of git man pages
Date: Wed, 30 Jul 2008 13:55:38 +0200
Message-ID: <1217418938.6924.2.camel@localhost>
References: <1217408012.9486.13.camel@hydra.esse.ch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fabio Scotoni <fabio@esse.ch>
X-From: git-owner@vger.kernel.org Wed Jul 30 13:56:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAIP-00084H-Ki
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 13:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbYG3Lzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 07:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756172AbYG3Lzn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 07:55:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:24490 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbYG3Lzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 07:55:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so128622fgg.17
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 04:55:40 -0700 (PDT)
Received: by 10.86.82.16 with SMTP id f16mr4801016fgb.16.1217418940493;
        Wed, 30 Jul 2008 04:55:40 -0700 (PDT)
Received: from ?192.168.1.15? ( [213.3.44.95])
        by mx.google.com with ESMTPS id l19sm1056908fgb.7.2008.07.30.04.55.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Jul 2008 04:55:39 -0700 (PDT)
In-Reply-To: <1217408012.9486.13.camel@hydra.esse.ch>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90767>

On Wed, 2008-07-30 at 10:53 +0200, Fabio Scotoni wrote:
> Hello,
> 
> I'm currently trying to translate the git man pages into german, as some
> of my co-developers want to stick with svn. Of course, I could use
> git-svn, but it's not what i want. Our svn server crashed two times and
> we lost the history two times.
> 
> Our native language is german and they don't like to read english
> documentation. I already started translating but have some problems:
> Should i translate "branch" with the appropriate german word or keep it
> english? This is a Problem for "pull" "push" and the other actions as
> well. Basically it's possible to copy words, but that isn't very
> esthetical.

There was a long discussion some months ago on this list concering the
localization of git-gui into german. Maybe you'll find some inspiration
here:

http://git.kernel.org/?p=git/git.git;a=blob;f=git-gui/po/de.po;hb=HEAD

It would probably be very worthwile to follow the translations there
because users of git-gui will feel at home at once instead of having to
re-learn things.

Matthias
