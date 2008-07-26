From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 08:32:19 -0700
Message-ID: <d411cc4a0807260832g21fc9a66yd5ccc370699993fd@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <20080726015314.GU32184@machine.or.cz>
	 <20080726020951.GV32184@machine.or.cz>
	 <7v4p6dnv5k.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0807252343n2b9ade68veaebb68664f0a3d7@mail.gmail.com>
	 <7vtzedktmi.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0807260027t4b9c3b08x1f865ec75d976ef6@mail.gmail.com>
	 <488B394F.9000300@keyaccess.nl> <m3d4l0vfgk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:33:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMllp-0001Gn-Qi
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYGZPcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYGZPcW
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:32:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:62409 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbYGZPcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:32:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3848440rvb.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=njolMN9Js8farJbdoX30thIjOahD13oX9SuEYUHsh7k=;
        b=uVnpdHc/HTk9mz02LqNCfCBciL8JQQPAlzrECTQIHPpBLBH3hHLwbuhcVyUrZCmwUX
         pb/19JziLEvp8thA+QGmip+KcP25OYPQvzauAEEEDA8lb+cGAwIFUUORPu0RXNLJ26gM
         bVdYTa9pSfWYFtVaFSuVNWippzXjf4ozcuqQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NSeUm8OltuVmIghsr8Ym4x/d0KadWhfjyQHwO37zTTIjIVWdCPCYaopxk1K5RZi/pd
         ANMH6PcOSK4BJ1vBiSnhU6oFARjcUA+gUGqpnKvFwyujy4IIltJqIiIFjoTJoV4x24fW
         OaJASE6CdrjKAbO2WRzP7yMEbsmPkjFu0HGPQ=
Received: by 10.115.59.2 with SMTP id m2mr3216499wak.197.1217086339224;
        Sat, 26 Jul 2008 08:32:19 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Sat, 26 Jul 2008 08:32:19 -0700 (PDT)
In-Reply-To: <m3d4l0vfgk.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90242>

On Sat, Jul 26, 2008 at 8:21 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Rene Herman <rene.herman@keyaccess.nl> writes:
>
>> On 26-07-08 09:27, Scott Chacon wrote:
>>
>> > Perhaps it would be useful to split the mailing list into
>> > core/contrib and support lists?  I would be happy to help out
>> > answering questions - a lot of them come directly to me anyhow
>> > because of the gitcasts site and such.
>>
>> A git-user list would be welcomed at least by me. It remains to be
>> seen how useful it would be (and stay) as often the user lists for a
>> project dwinddle a bit but I've subcribed and unsubscribed to this
>> list a number of times now since unless I've a specific question to
>> ask, the list is too busy too just sit around on; I end up deleting
>> all list mail unread every night anyway, so I just unsubcribe again.
>>
>> Maybe a less busy and less implementation focused list could help "me
>> and mine" gradually pick up new tips and tricks. Depends ofcourse on
>> willingness of some of the more proficient to be involved in that list
>> as well...
>
> Well, there _is_ separate Git Users Group at Google Groups
>  http://groups.google.com/group/git-users
>  nntp://news.gmane.org/gmane.comp.version-control.git.user
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>

Perhaps I should link to that on git-scm as well / instead?

Scott
