From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 12:27:13 +0000 (GMT)
Message-ID: <843148.96940.qm@web27803.mail.ukl.yahoo.com>
References: <2c6b72b30909040522l4f27ed36u10f47517d42d57a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:27:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjXsy-0005C4-R9
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825AbZIDM1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbZIDM1M
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:27:12 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:43532 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753432AbZIDM1M (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 08:27:12 -0400
Received: (qmail 97035 invoked by uid 60001); 4 Sep 2009 12:27:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1252067233; bh=UVDzIcyixwEU0MxGyKlPcgNdZIoD98FJHK4TQBBS16Y=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=lJr9bTUO+knp1I03vuTYalcsVnRR5Nwbzz7cIyHi53CAi52ngljZYJDZuxb2TJwzVWssHuEt19NIMdB9FFHoR6haeaEy1cry+18rA3s65g/B5REwCDG6b8OAVKNh7wNlhR2P2a3EY9TjcpkOaiqn4czTl/5yZkrjyay4t/kqQTs=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=4oVRgP1O/1dACJV9RO9/h8Sc3ypYwNuvHrSIGchk2Nh4h6tA8dMqEs64L22W4zNYCWbDB2D20Z7Zrkw20IFMrsMmANPMog7yzpvj1wqHeKvZ4VInZ6Oyi1Gb8FVDBwrRW5KD2gns/Xu2TKWc6LJVQmgxLf/9O8DH9sRG1SgLIi0=;
X-YMail-OSG: KMn1L6MVM1l8xTO84y0gEWycNDT1ShRRbcSgW6QImbn0lC2Zwsu39kqSQVQXbt5z7LDCxtZr90k_OnuLwvzc4MWMZGimh3hWlMPIQWY4w2GuMJrE01hqsUnRqEf9jvGAWEoM2EOPQPnnH2oHN0HuyRGtlEaJ6.90XfRvWkPriJBhUkz9dWHrmbLyxhDXm9YmWjNqZALWPYjSgbeZ7VTWNW7I563BTkS45VdWsmH9VTICsX.oEC0Ic9MF_JVv7t.DfGPwyZ6YIkxlceyL3wSIrUvs2J7R4CTNoK6HfOZGviNv3iLDJRcZuA2l9mUc3ONwsPbuzVYw
Received: from [81.16.153.112] by web27803.mail.ukl.yahoo.com via HTTP; Fri, 04 Sep 2009 12:27:13 GMT
X-Mailer: YahooMailClassic/6.1.2 YahooMailWebService/0.7.338.2
In-Reply-To: <2c6b72b30909040522l4f27ed36u10f47517d42d57a3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127725>

Hi Jonas!

See the following documentation:

http://maven.apache.org/plugins/maven-release-plugin/index.html
http://maven.apache.org/plugins/maven-release-plugin/examples/prepare-release.html
http://maven.apache.org/plugins/maven-release-plugin/examples/perform-release.html

There is also a freely available book from sonatype [1] which contains all the documemtation you need - plus fn lot more :)

LieGrue,
strub

[1] http://www.sonatype.com/book/


--- On Fri, 9/4/09, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:

> From: Jonas Fonseca <jonas.fonseca@gmail.com>
> Subject: Re: [JGIT] Request for help
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: git@vger.kernel.org, "Gabe McArthur" <gabriel.mcarthur@gmail.com>
> Date: Friday, September 4, 2009, 2:22 PM
> On Fri, Sep 4, 2009 at 03:33, Mark
> Struberg<struberg@yahoo.de>
> wrote:
> > .) we don't need a tag.sh any more if we work with
> maven. Maven now has the maven-scm-provider-gitexe activated
> by default (since early 2008), so
> > mvn release:prepare
> > mvn release:perform
> > should work if we set the proper <scm> section.
> Any feedback or bugreporting on the maven-git integration is
> highly welcome btw ;)
> 
> If tag_jgit.sh goes away, it could be nice to add a
> document showing
> how releasing/tagging it's done the maven way.
> 
> -- 
> Jonas Fonseca
> 


      
