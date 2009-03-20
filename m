From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: Status of GIT for Fedora 10 + gitweb's look
Date: Fri, 20 Mar 2009 18:02:50 -0000
Message-ID: <989A5B661A8E4F099363D86CA16D3D84@HPLAPTOP>
References: <B041B86F1FF246ACBD68051753788FBE@HPLAPTOP>	 <49C3C2A0.2030402@eaglescrag.net>	 <9719867c0903200928y68981153w7728f3d1136a9713@mail.gmail.com>	 <49C3C522.7070004@eaglescrag.net> <9719867c0903201023x2edb6c72s5ba5d5d78e97e56e@mail.gmail.com> <49C3D252.4070009@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:04:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkj5M-0001g6-C3
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 19:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758745AbZCTSC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758593AbZCTSC7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 14:02:59 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:59215 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbZCTSC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 14:02:57 -0400
Received: by ewy9 with SMTP id 9so822910ewy.37
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:references
         :subject:date:mime-version:content-type:content-transfer-encoding
         :x-priority:x-msmail-priority:x-mailer:x-mimeole;
        bh=pcGLb1bc0zHSZ5oh4oXUqgJQV8kQCW1Yag2NFVaQeW8=;
        b=lJjo/TWxMDHw8hVVdsjxG2HouaV7yqr7zb1MSbC27w9enEmbdjrjzyQSOmrDJMjvpF
         TqGrwqgTlP8z4qZjvBSlHRJCtnRHe7mZsNGq9hTFlg29ydGDNhOgCnt9OIKebElUyhd2
         QQwwHJJqtuqf4sNi3KwhyQHPdvQs/1gcPBTPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=lpsYObbyqS3TC4Vry8m6VAe7B1/TccGlTSa2SStGAE84ytKayPSEqT+6F7aKitKVOg
         9S+5VCPB/PkCk8MzzaV9iF2wByOhDQXFoLVd5M5X4TO/nuUOKYO2Y6zPePvGDgrN22Nd
         jCQhw/IRQHBuT6Bfii+VdhzOE3yh1RAk7BBiU=
Received: by 10.216.6.200 with SMTP id 50mr1560188wen.117.1237572174166;
        Fri, 20 Mar 2009 11:02:54 -0700 (PDT)
Received: from HPLAPTOP (aarongray.demon.co.uk [80.177.163.94])
        by mx.google.com with ESMTPS id f7sm4056234nfh.13.2009.03.20.11.02.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Mar 2009 11:02:53 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113987>

Got it :-

    http://www.somegitserver.com/git/gitweb.cgi

This should work straight out of the bag with Fedora.

Aaron

> - John 'Warthog9' Hawley
>
> Aaron Gray wrote:
>> On Fri, Mar 20, 2009 at 4:32 PM, J.H. <warthog19@eaglescrag.net 
>> <mailto:warthog19@eaglescrag.net>> wrote:
>>
>>     Considering that the version running on kernel.org
>>     <http://kernel.org/> is
>>
>>     1) a Forked copy and
>>     2) Based on code thats over 3 years old
>>
>>     My guess is that your missing a style sheet or a link in your apache
>>     config for gitweb.  The latest version should look more or less the
>>     same as what's up on git.kernel.org <http://git.kernel.org/>.  Take
>>     a look in your browser and see if it can give you any hints as to
>>     what the error is, what it can't download, etc.
>>
>>  Your right its not picking up the CSS !
>>  I have :-
>>  /var/www/cgi-bin/
>>         gitweb.cgi
>>         gitweb.css
>>  I am wondering whether its a configuration problem, permissions and 
>> SELinux is in premissive mode. It looks like it may be Apache 
>> configuration. I tried a test hello.cgi, and hello.css and Apache does 
>> not seem to be reading '.css' file from cgi-bin.
>>  I'll go over to the Apache group if noone can help me here.
>>  Cheers,
>>  Aaron
>>
>> - John 'Warthog9' Hawley
>>
>> Aaron Gray wrote:
>>
>>         On Fri, Mar 20, 2009 at 4:21 PM, J.H. <warthog19@eaglescrag.net
>>         <mailto:warthog19@eaglescrag.net>
>>         <mailto:warthog19@eaglescrag.net
>>         <mailto:warthog19@eaglescrag.net>>> wrote:
>>
>>            If your on Fedora 10 to get gitweb installed all you should
>>         have to
>>            do is:
>>
>>            yum install gitweb
>>
>>            and you will be off and running.
>>
>>          Its all running. It installed 1.6.0.6-1 I wanted to get
>>         1.6.2.1-1 only for the reason of gitweb.
>>          gitweb appears as text rather than nice html tables. Does the
>>         latest version look like http://git.kernel.org/ or do I have to
>>         do my own HTML formatting ?
>>          Cheers,
>>          Aaron
>>            - John 'Warthog9' Hawley
>>
>>            Aaron Gray wrote:
>>
>>                I tried installing Git on F10 and got the following :-
>>
>>                [root@localhost ~]# rpm -Uvh git-1.6.2.1-1.fc9.i386.rpm
>>                error: Failed dependencies:
>>                      perl-Git = 1.6.2.1-1.fc9 is needed by
>>         git-1.6.2.1-1.fc9.i386
>>                      git = 1.6.0.6-3.fc10 is needed by (installed)
>>                perl-Git-1.6.0.6-3.fc10.i386
>>                      git = 1.6.0.6-3.fc10 is needed by (installed)
>>                git-svn-1.6.0.6-3.fc10.i386
>>                      git = 1.6.0.6-3.fc10 is needed by (installed)
>>                git-daemon-1.6.0.6-3.fc10.i386
>>                      git = 1.6.0.6-3.fc10 is needed by (installed)
>>                gitweb-1.6.0.6-3.fc10.i386
>>
>>
>>                Can I install from source I could only find F9 SRPMS.
>>
>>                What I am really after knowing is gitweb on the latest
>>         version
>>                1.6.2.1 anything like the nice HTML layout on
>>                http://git.kernel.org/ or do I have to do the html 
>> formatting
>>                myself in the perl code ?
>>
>>                Many thanks in advance,
>>
>>                Aaron
>>
>>                --        To unsubscribe from this list: send the line
>>         "unsubscribe git" in
>>                the body of a message to majordomo@vger.kernel.org
>>         <mailto:majordomo@vger.kernel.org>
>>                <mailto:majordomo@vger.kernel.org
>>         <mailto:majordomo@vger.kernel.org>>
>>
>>                More majordomo info at
>>          http://vger.kernel.org/majordomo-info.html
>>
>> 
