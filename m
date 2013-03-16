From: Adam Retter <adam@exist-db.org>
Subject: Re: git svn error "Not a valid object name"
Date: Sat, 16 Mar 2013 18:54:32 +0000
Message-ID: <CAJKLP9Zo_3fdXW0eNBo+qrgomZ_PtbLbDKyqtwLZsGecN2B8iA@mail.gmail.com>
References: <CAJKLP9ZQBXf5ZZY9FccOAL5QU+q1b5SnAfvP9BpARdqvzPuWeg@mail.gmail.com>
	<20130316014548.GA16253@dcvr.yhbt.net>
	<CAJKLP9aX20i+oy7AMhh5+uAmP2Np4tUGTEvR+XDHyG1a_DSXtQ@mail.gmail.com>
	<20130316171354.GA2427@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Dannes Wessels <dannes@exist-db.org>,
	Wolfgang Meier <wolfgang@exist-db.org>,
	=?UTF-8?B?TGVpZi1Kw7ZyYW4gT2xzc29u?= <ljo@exist-db.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Mar 16 19:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGwFw-0003Xq-6A
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 19:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab3CPSyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 14:54:33 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:61248 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab3CPSyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 14:54:33 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so4227462obc.27
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 11:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=4MBdoLHUNYft9WD6OBlcENL2cR0tDocAw2Urfg2JbHE=;
        b=Odym3gYyPup6E3USTJHnIAfGZKBbF3sV8q/MTGc8+MDxBxsW60WpO4Kr2tqlqAOFWE
         NeWgZOpOUm0N0x6vRilOyikLt5F+YAMmHN8liGgKDrRJkVNIjFyEnDIW13Ew1TT2VYii
         5A9yLKcJOCjmFgwzzxyKPsp56DxrEkx+olRco2zrtsssRmEH8E+xuUImBROr6CutDtQH
         E7ydY6AKL8M4nprxWNWzPM9t8lRVvaxb/vOAQBeaQfC+m+FRyfhkHhJ7RI/1PX/Tg8em
         wmMDz3gVX4Td57unYOwMD9K08GxKZo9eZWrhugRY1RQINobOcDNHdFXcVzenKs0sYW+Z
         RrBw==
X-Received: by 10.182.64.74 with SMTP id m10mr4642460obs.61.1363460072307;
 Sat, 16 Mar 2013 11:54:32 -0700 (PDT)
Received: by 10.76.33.166 with HTTP; Sat, 16 Mar 2013 11:54:32 -0700 (PDT)
In-Reply-To: <20130316171354.GA2427@dcvr.yhbt.net>
X-Gm-Message-State: ALoCoQn/2hUDZOgSgPAIvma/3pKjL4WC3xHWWkWlxKV/NnyJhRUsU/RfTkauPhUCmXxol3c4LRJP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218313>

Ah right yes, sorry the HTTPS version needs a username the HTTP
version does not. Please use:

http://svn.code.sf.net/p/exist/code

On 16 March 2013 17:13, Eric Wong <normalperson@yhbt.net> wrote:
> Adam Retter <adam@exist-db.org> wrote:
>> If your able, any idea of when you might be able to take a look at the
>> bug? Our svn repo is publicly available for all.
>
> svn ls https://svn.code.sf.net/p/exist/code/trunk
> ...Is asking me for username



--
Adam Retter

eXist Developer
{ United Kingdom }
adam@exist-db.org
irc://irc.freenode.net/existdb
